library(tidyverse)
library(pomp)
library(foreach)
library(future)
library(doFuture)
library(iterators)

covid_data = read_csv("weekly_data.csv")

KERALA_POP = 34530000
NP = 5000; NMIF = 200; NUM_GUESSES = 400
interval = c(61, 35, 23)

seir_step <- Csnippet("

  double Beta;
  if (interval == 1) Beta = b1;
  else if (interval == 2) Beta = b2;
  else Beta = b3;

  double dN_SE = rbinom(S,1-exp(-Beta*I/N*dt));
  double dN_EI = rbinom(E,1-exp(-mu_EI*dt));
  double dN_IR = rbinom(I,1-exp(-mu_IR*dt));

  double dN_RS = rbinom(R, 1 - exp(-mu_RS*dt));

  S -= dN_SE - dN_RS;

  E += dN_SE - dN_EI;
  I += dN_EI - dN_IR;
  R += dN_IR;
  H += dN_IR;
")

seir_init <- Csnippet("
  S = nearbyint(eta*N);
  E = 0;
  I = 2000;
  R = nearbyint((1-eta)*N);
  H = 0;
")

dmeas <- Csnippet("

  double k;
  if (interval == 1) k = k1;
  else if (interval == 2) k = k2;
  else k = k3;

  double mean_reports = fmax(rho * H, 1e-5);
  lik = dnbinom_mu(reports, k, mean_reports, give_log);
")

rmeas <- Csnippet("

  double k;
  if (interval == 1) k = k1;
  else if (interval == 2) k = k2;
  else k = k3;

  reports = rnbinom_mu(k,rho*H);"
)

emeas <- Csnippet("
  E_reports = rho*H;"
)

time_indicators = covariate_table(
  t = covid_data$Week_Number,
  interval = c(rep(1, interval[1]), rep(2, interval[2]), rep(3, interval[3])), 
  times = "t")

## MODEL INIT

init_params = c(b1=5,b2=10,b3=20,rho=.4, mu_EI=1/0.6, mu_IR=1/2.5, mu_RS = .005, 
                k1=10, k2=5, k3=2, eta=.1,N=KERALA_POP) 

# assumptions: 4-4.5 days of incubation period; 2 weeks of recovery period; 26 weeks of immunity

cat("[INFO] Initial model parameters:\n")
setNames(sprintf("%.2f", init_params), names(init_params))

covid_data |>
  select(Week_Number,reports=Confirmed) |>
  filter(Week_Number<=119) |>
  pomp(
    times="Week_Number",t0=1,
    rprocess=euler(seir_step,delta.t=1/7),
    rinit=seir_init,
    rmeasure=rmeas,
    dmeasure=dmeas,
    emeasure=emeas,
    accumvars="H",
    statenames=c("S", "E","I","R","H"),
    paramnames=c("b1","b2","b3", "k1", "k2", "k3", "mu_EI","mu_IR", "mu_RS", "eta","rho", "N"),
    params=init_params,
    covar = time_indicators
  ) -> COVID_SEIR

registerDoFuture()
plan(multicore, workers = 36) 

set.seed(1350254336)
mifs_local = read_rds("local_search.rds")
fixed_params <- c(N=34530000, mu_RS = 0.005)
coef(COVID_SEIR,names(fixed_params)) <- fixed_params

set.seed(2062379496)
# small range on b2 and b3
runif_design(
  lower=c(b1=7, b2= 40, b3 = 30, k1 = 0, k2 = 4, k3 = 0, mu_EI = 1, mu_IR =0.5, rho=0.30, eta=0.1),
  upper=c(b1=9, b2 = 50, b3 = 40, k1 = 2.5, k2=5, k3= 1, mu_EI = 1.5, mu_IR =0.6, rho=0.36, eta=0.5),
  nseq=NUM_GUESSES
) -> guesses
mf1 <- mifs_local[[1]]

foreach(guess=iter(guesses,"row"), .combine=rbind,
        .options.future=list(seed=482947940)
) %dofuture% {
  mf1 |>
    mif2(params=c(guess,fixed_params)) |>
    mif2(Nmif=NMIF) -> mf
  replicate(
    10,
    mf |> pfilter(Np=NP) |> logLik()
  ) |>
    logmeanexp(se=TRUE) -> ll
  mf |> coef() |> bind_rows() |>
    bind_cols(loglik=ll[1],loglik.se=ll[2])
} -> seir_global_results
write.csv(seir_global_results, "Global_smaller.csv")


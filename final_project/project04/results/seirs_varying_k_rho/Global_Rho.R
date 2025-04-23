library(tidyverse)
library(pomp)
library(foreach)
library(future)
library(doFuture)
library(iterators)

covid_data = read_csv("weekly_data.csv")

KERALA_POP = 34530000
NP = 5000; NMIF = 200; NUM_GUESSES = 800
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
  I = 1000;
  R = nearbyint((1-eta)*N);
  H = 0;
")

dmeas <- Csnippet("
  double rho;
  if (interval == 1) rho = rho1;
  else if (interval == 2) rho = rho2;
  else rho = rho3;
  
  double k;
  if (interval == 1) k = k1;
  else if (interval == 2) k = k2;
  else k = k3;

  double mean_reports = fmax(rho * H, 1e-5);
  lik = dnbinom_mu(reports, k, mean_reports, give_log);
")

rmeas <- Csnippet("
  double rho;
  if (interval == 1) rho = rho1;
  else if (interval == 2) rho = rho2;
  else rho = rho3;
  
  double k;
  if (interval == 1) k = k1;
  else if (interval == 2) k = k2;
  else k = k3;

  reports = rnbinom_mu(k,rho*H);"
)

emeas <- Csnippet("
  double rho;
  if (interval == 1) rho = rho1;
  else if (interval == 2) rho = rho2;
  else rho = rho3;
  
  E_reports = rho*H;"
)

time_indicators = covariate_table(
  t = covid_data$Week_Number,
  interval = c(rep(1, interval[1]), rep(2, interval[2]), rep(3, interval[3])), 
  times = "t")

## MODEL INIT

init_params = c(b1=2.33, b2=3.68, b3=11.40, rho1=.07, rho2 =.51, rho3=.11, mu_EI=1.23, mu_IR=1.17, mu_RS = .005, 
                k1=1.26, k2=6, k3=2.8, eta=.62, N=KERALA_POP) 

cat("[INFO] Initial model parameters:\n")
setNames(sprintf("%.2f", init_params), names(init_params))

covid_data |>
  dplyr::select(Week_Number,reports=Confirmed) |>
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
    # paramnames=c("b1","b2","b3","mu_EI","mu_IR", "mu_RS", "eta","rho","k","N"),
    paramnames=c("b1","b2","b3","mu_EI","mu_IR", "mu_RS", "eta","rho1","rho2", "rho3", "k1", "k2", "k3", "N"),
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
runif_design(
  lower=c(b1=1, b2= 5, b3 = 10, k1 = 1, k2 = 1, k3 = 1, mu_EI = 1, mu_IR= 0.1, rho1=0.05, rho2=0.3, rho3=0.4, eta=0),
  upper=c(b1=5, b2 = 50, b3 = 50, k1 = 5, k2=5, k3= 5, mu_EI = 5, mu_IR= 0.5, rho1=0.3, rho2=0.6, rho3=0.8, eta=1),
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
write.csv(seir_global_results, "Global_rho_800.csv")


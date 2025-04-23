library(tidyverse)
library(iterators)
library(knitr)
library(foreach)
library(doFuture)
library(pomp)
if (.Platform$OS.type == "windows") {
  options(pomp_cdir="./tmp")
}

# Load from EDA

data = read.csv("ilitotal2015.csv")

registerDoFuture()

cores <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
if(is.na(cores) || cores < 1) cores <- parallel::detectCores(logical=FALSE)

plan(multisession, workers=cores)

set.seed(1280094583)

# SEIRS model

seirs_step <- Csnippet("
  double dN_SE = rbinom(S,1-exp(-Beta*I/N*dt));
  double dN_EI = rbinom(E, 1 - exp(-mu_EI * dt));
  double dN_IR = rbinom(I,1-exp(-mu_IR*dt));
  double dN_RS = rbinom(R, 1 - exp(-mu_RS * dt));
  S += dN_RS - dN_SE;
  E += dN_SE - dN_EI;
  I += dN_EI - dN_IR;
  R += dN_IR - dN_RS;
  H += dN_EI;" 
) # H tracks incident symptomatic cases, consistent with ILI report definitions

seirs_init <- Csnippet("
  S = nearbyint((1-eta)*N);
  E = 0;
  I = nearbyint(eta*N);
  R = 0;
  H = 0;
")

dmeas <- Csnippet("
  double mean = (rho * H < 1) ? 1 : rho * H;
  lik = dnbinom_mu(reports,k,mean,give_log);"
)

rmeas <- Csnippet("
  reports = rnbinom_mu(k,rho*H);"
)

data |> select(reports = ILITOTAL) |> 
  pomp(
    times=row_number(data), t0 = 0,
    rprocess=euler(seirs_step,delta.t=1/7),
    rinit=seirs_init,
    rmeasure=rmeas,
    dmeasure=dmeas,
    accumvars="H",
    partrans=parameter_trans(log=c("Beta", "mu_EI", "mu_IR", "mu_RS", "k"), logit=c("rho","eta")),
    paramnames=c("Beta","mu_EI","mu_IR", "mu_RS", "rho","eta", "k", "N"),
    statenames=c("S","E","I","R","H"), 
    params=c(Beta = 5, mu_EI = 1/2*7, mu_IR = 1/5*7, mu_RS = 1/18, rho = 0.945, eta = 0.033,  k = 10, N = 52900000) # N = total population of region 5
  ) -> flu_seirs

# Uncomment for sanity check and local search with SEIRS

# Sanity check

# coef(flu_seirs) <- c(Beta = 1, mu_EI = 1.5, mu_IR = 1, mu_RS = 0.01, rho = 0.01, eta = 1e-4, k = 3, N = 52900000)
# coef(flu_seirs)

# log likelihood check
# 
foreach(i=1:10,.combine=c,
        .options.future=list(seed=TRUE)
) %dofuture% {
  flu_seirs |> pfilter(Np=5000)
} -> pf
pf |> logLik() |> logmeanexp(se=TRUE) -> L_pf
L_pf

# ESS check
flu_seirs |>
  pfilter(Np=5000) -> pf
plot(pf)

# Local search

bake(file="seirs_local_searchfk1.rds",{
  foreach(i=1:20,.combine=c,
          .options.future=list(seed=482947940)
  ) %dofuture% {
    flu_seirs |>
      mif2(
        Np=5000, Nmif=50,
        cooling.fraction.50=0.5,
        rw.sd=rw_sd(Beta=0.02, mu_IR = 0.02, mu_EI = 0.02, mu_RS = 0.02, rho=0.02, eta=ivp(0.02), k=0.1)
      )
  } -> seirs_mifs_local
  seirs_mifs_local
}) -> seirs_mifs_local

# Local log likelihood simulation

seirs_mifs_local <- readRDS("seirs_local_searchfk1.rds")

bake(file="seirs_local_loglikfk1.rds", {
  foreach(mf=seirs_mifs_local,.combine=rbind,
          .options.future=list(seed=900242057)
  ) %dofuture% {
    evals <- replicate(10, logLik(pfilter(mf,Np=5000)))
    ll <- logmeanexp(evals,se=TRUE)
    mf |> coef() |> bind_rows() |>
      bind_cols(loglik=ll[1],loglik.se=ll[2], Np=2000, nfilt=10)
  }
}) -> local_loglik

# read_csv("seirs_params.csv") |>
#   bind_rows(local_loglik) |>
#   arrange(-loglik) |>
#   write_csv("seirs_params.csv")

seirs_mifs_local <- readRDS("seirs_local_searchfk1.rds")

# Global search

mf1 <- seirs_mifs_local[[1]]

fixed_params <- c(N=52900000)

guesses <- runif_design(
  lower=c(Beta=1, mu_IR = 1, mu_EI = 1.5, mu_RS = 0.01, rho=0.01,eta=1e-4, k=3),
  upper=c(Beta=5, mu_IR = 4, mu_EI = 7, mu_RS = 0.1, rho=0.1, eta=0.01, k=30), nseq=200 # Have to wait for local search to reduce the dimension
)

bake(file="seirs_global_searchfk1.rds", {
  foreach(guess=iter(guesses,"row"), .combine=rbind,
          .options.future=list(seed=1270401374) ) %dofuture% {
            mf1 |>
              mif2(params=c(guess,fixed_params),
                   rw.sd=rw_sd(Beta=0.02, mu_IR = 0.02, mu_EI = 0.02, mu_RS = 0.02, rho=0.02, eta=ivp(0.02), k=0.1),
                   Np=2000, Nmif=50) |>
              mif2(Nmif=50)-> mf
            replicate(
              10,
              mf |> pfilter(Np=5000) |> logLik()
            ) |>
              logmeanexp(se=TRUE)-> ll
            mf |> coef() |> bind_rows() |>
              bind_cols(loglik=ll[1],loglik.se=ll[2]) }
}) -> seirs_mifs_global

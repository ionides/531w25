library(pomp)
library(tidyverse)
library(doFuture)
library(doParallel)
library(doRNG)
library(iterators)
data <- read.csv("Lab-confirmed_Influenza_Cases.csv")
data$Date <- as.Date(data$Week.Ending, format = "%b %d, %Y")


# Filter and create the time variable (in weeks since first date)
data <- data %>%
  filter(Date >= as.Date("2014-09-06") & Date <= as.Date("2019-09-07")) %>%
  arrange(Date) %>%
  mutate(
    week = as.numeric(difftime(Date, min(Date), units = "weeks")),
    cases = Lab.Confirmed.Influenza.Cases
  ) %>%
  select(week, cases)
# SEIRS model 
seirs_step <- Csnippet("
  double pi = 3.141593;
  double Beta = Beta0 * (1 + amp * sin(2 * pi * (t + phase) / 52));
  double dN_SE = rbinom(S, 1 - exp(-Beta * I / N * dt));
  double dN_EI = rbinom(E, 1 - exp(-mu_EI * dt));
  double dN_IR = rbinom(I, 1 - exp(-mu_IR * dt));
  double dN_RS = rbinom(R, 1 - exp(-mu_RS * dt));
  S += dN_RS - dN_SE;
  E += dN_SE - dN_EI;
  I += dN_EI - dN_IR;
  R += dN_IR - dN_RS;
  H += dN_IR;
  ")

seirs_rinit <- Csnippet("
 double pop = N / (S0 + E0 + I0 + R0);
  S = nearbyint(S0 * pop);
  E = nearbyint(E0 * pop);
  I = nearbyint(I0 * pop);
  R = nearbyint(R0 * pop);
  H = 0;
  ")

seirs_dmeas <- Csnippet("
  lik = dnbinom_mu(cases, k, rho * H, give_log);
  ")

seirs_rmeas <- Csnippet("
  cases = rnbinom_mu(k, rho * H);
  ")

seirs_pomp <- pomp(
  data=data,
  times = "week",
  t0 = 0,
  rprocess = euler(seirs_step, delta.t = 1 / 7),
  rinit = seirs_rinit, 
  rmeasure = seirs_rmeas,
  dmeasure = seirs_dmeas,
  accumvars = "H",
  statenames = c("S", "E", "I", "R", "H"),
  paramnames = c("Beta0", "amp", "phase", "mu_EI", "mu_IR", "mu_RS", "N", "S0", "E0", "I0", "R0", "rho", "k"),
  partrans = parameter_trans(
    log = c("Beta0", "mu_EI", "mu_IR", "mu_RS", "k"),
    logit = c("amp", "rho"),
    barycentric = c("S0", "E0", "I0", "R0")
  )
)
params <- c(
  Beta0 = 2, amp = 0.3, phase = -4.5,
  mu_EI = 0.8, mu_IR = 2, mu_RS = 1,
  N = 969400, S0 = 0.1, E0 = 0.01, I0 = 0.01, R0 = 0.3,
  rho = 0.0005, k = 10
)
coef(seirs_pomp) <- params

registerDoParallel(30)
registerDoRNG(seed = 123456)

run_level <- 3
Np              <- switch(run_level, 100, 1e3, 2e3, 2e3)
Nlocal          <- switch(run_level, 2, 5, 20, 100)
Nglobal         <- switch(run_level, 2, 5, 100, 200)
Npoints_profile <- switch(run_level, 4, 10, 50, 200)
Nreps_profile   <- switch(run_level, 2, 4, 15, 100)
Nmif            <- switch(run_level, 10, 50, 100, 250)
Nreps_eval      <- switch(run_level, 2, 5, 10, 50)

local_mifs_seirs <- readRDS("seirs_ls.RDS")
mf1 <- local_mifs_seirs[[1]]

read_csv("influenza_params.csv") |>
  group_by(cut=round(rho,5)) |>
  filter(rank(-loglik)<=10) |>
  ungroup() |>
  arrange(-loglik) |>
  select(-cut,-loglik,-loglik.se)-> guesses

fixed_params <- c(N=969400)

pf_results<-bake(file="seirs_pf.RDS",{
  pf_results<-foreach(guess=iter(guesses,"row"), .combine=rbind,
        .packages=c("pomp", "tidyverse")) %dopar% {
  mf1 |>
    mif2(params=guess,
         rw.sd=rw_sd(Beta0 = 0.01, amp = 0.01, phase = 0.01, 
                     mu_EI = 0.002, mu_IR = 0.002,  mu_RS = 0.01, 
                     S0 = ivp(0.002), E0 = ivp(0.002), 
                     I0 = ivp(0.002), R0 = ivp(0.002),
                     k=0.01)) |>
    mif2(Nmif=Nmif,cooling.fraction.50=0.3) |>
    mif2()-> mf
  replicate(
    10,
    mf |> pfilter(Np=Np) |> logLik()) |>
    logmeanexp(se=TRUE)-> ll
  mf |> coef() |> bind_rows() |>
    bind_cols(loglik=ll[1],loglik.se=ll[2])
  }
  pf_results
})
  
 

  
  
  
  
  
  

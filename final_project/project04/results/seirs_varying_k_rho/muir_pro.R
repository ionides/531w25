library(tidyverse)
library(pomp)
library(foreach)
library(future)
library(doFuture)
library(iterators)

NP = 5000; NMIF = 100; NUM_GUESSES = 800
registerDoFuture()
plan(multicore, workers = 36) 

mifs_local = read_rds("local_search.rds")
mf1 <- mifs_local[[1]]

seir_global_results = read.csv("SEIR_Global_rho_800.csv")
seir_global_results |>
  group_by(cut=round(mu_IR,2)) |>
  filter(rank(-loglik)<=40) |>
  ungroup() |>
  arrange(-loglik) |>
  select(-cut,-loglik,-loglik.se) -> guesses

foreach(guess=iter(guesses,"row"), .combine=rbind,
        .options.future=list(seed=2105684752)
) %dofuture% {
  mf1 |>
    mif2(params=guess,
         rw.sd=rw_sd(b1=0.01, b2=0.02, b3=0.02, k1 = 0.01, k2 = 0.02, k3=0.02, rho1=.02, rho2=.02, rho3=.02, mu_EI = 0.005, mu_RS=0.00, eta=ivp(0.02))) |>
    mif2(Nmif=NMIF,cooling.fraction.50=0.3) |>
    mif2() -> mf
  replicate(
    10,
    mf |> pfilter(Np=NP) |> logLik()) |>
    logmeanexp(se=TRUE) -> ll
  mf |> coef() |> bind_rows() |>
    bind_cols(loglik=ll[1],loglik.se=ll[2])
} -> profile_results
write.csv(profile_results, "muir_profile_800.csv")


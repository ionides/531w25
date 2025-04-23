suppressPackageStartupMessages({
library(tidyverse)
library(pomp)
library(foreach)
library(future)
library(doFuture)
library(iterators)
})

registerDoFuture()

cores <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
if (is.na(cores) || cores < 1) cores <- parallel::detectCores(logical=FALSE)

plan(multisession, workers = cores)

set.seed(1350254336)


KERALA_POP = 34530000

NP = 5000; NMIF = 200; NUM_GUESSES = 400
# NP = 200; NMIF = 10; NUM_GUESSES = 40 # debug line

cat("[INFO] Iteration parameters: Np =", NP, " | Nmif =", NMIF, "\n")

interval = c(61, 35, 23) # DO NOT change the first entry. It's the time when the vaccination program started.

cat(sprintf("[INFO] Time interval (in weeks): [1 - %d], [%d - %d], [%d - %d]\n", interval[1], interval[1] + 1, interval[1] + interval[2], 
    interval[1] + interval[2] + 1, sum(interval)))


# The code for the SEIR model is developed from https://kingaa.github.io/sbied/pfilter/model.R

covid_data = read.csv("./data/weekly_df.csv")


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
  double mean_reports = fmax(rho * H, 1e-5);
  lik = dnbinom_mu(reports, k, mean_reports, give_log);
")

rmeas <- Csnippet("
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

init_params = c(b1=5,b2=10,b3=20,rho=.4, mu_EI=1/0.6, mu_IR=1/2.5, mu_RS = .005, k=10, eta=.1,N=KERALA_POP) 

# assumptions: 4-4.5 days of incubation period; 2 weeks of recovery period; 26 weeks of immunity

cat("[INFO] Initial model parameters:\n")
setNames(sprintf("%.3f", init_params), names(init_params))

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
    paramnames=c("b1","b2","b3","mu_EI","mu_IR", "mu_RS", "eta","rho","k","N"),
    params=init_params,
    covar = time_indicators
  ) -> COVID_SEIR

### Check the particle filter

COVID_SEIR |> pfilter(Np = 5000) -> p_filter
png("./pic/ess_init.png", width = 800, height = 600)
plot(p_filter)
dev.off()

### Simulation based on initial params

sim_df <- simulate(COVID_SEIR, nsim = 5, format = "data.frame") |>
  select(Week_Number, .id, reports) |>
  mutate(source = "Simulated")

real_df <- covid_data |>
  select(Week_Number, Confirmed) |>
  rename(reports = Confirmed) |>
  mutate(source = "Observed")

(
  bind_rows(sim_df, real_df) |>
  ggplot(aes(x = Week_Number, y = reports, color = source)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated vs. Observed Weekly COVID-19 Cases, Init Params",
    x = "Week",
    y = "Reported Cases",
    color = "Data Source"
  ) +
  theme_minimal()
  ) |>
  ggsave(
    filename = "./pic/sim_init.png",
    plot = _,
    width = 8,
    height = 5,
    dpi = 300
  )


### A quick sanity check
ll <- replicate(10, logLik(pfilter(COVID_SEIR, Np = NP))) |>
  logmeanexp(se = TRUE)
cat("[INFO] Sanity Check: loglik =", round(ll[1], 2), " | SE =", round(ll[2], 4), "\n")


## LOCAL SEARCH
# step_size = c(b1 = .01, b2=.02, b3 = .02, rho = .002, eta = .02)
step_size = rw_sd(b1 = .01, b2=.02, b3 = .02, mu_EI = .005, mu_IR = .005, 
              mu_RS = .00, rho = .002, eta = ivp(.02))
cat("[INFO] Local search initiated.\n")
cat("[INFO] Step size:\n")
# setNames(sprintf("%.3f", step_size), param_names)
print(step_size@call)

bake(file="local_search.rds",{
  foreach(i=1:20,.combine=c,
    .options.future=list(seed=482947940)
  ) %dopar% {
    COVID_SEIR |>
      mif2(
        Np=NP, Nmif=NMIF,
        cooling.fraction.50=0.5,
        rw.sd = step_size,
        # partrans=parameter_trans(log=c("b1","b2","b3"),logit=c("rho","eta")),
        # paramnames=c("b1","b2","b3","rho","eta")
        partrans=parameter_trans(log=c("b1","b2","b3", "mu_EI", "mu_IR",
        "mu_RS"),logit=c("rho","eta")),
        paramnames=c("b1","b2","b3","mu_EI", "mu_IR", "mu_RS", "rho","eta")
      )
  } -> mifs_local
  attr(mifs_local,"ncpu") <- nbrOfWorkers()
  mifs_local
}) -> mifs_local


bake(file="lik_local.rds",{
  foreach(mf=mifs_local,.combine=rbind,
    .options.future=list(seed=900242057)
  ) %dopar% {
    evals <- replicate(10, logLik(pfilter(mf,Np=NP)))
    ll <- logmeanexp(evals,se=TRUE)
    mf |> coef() |> bind_rows() |>
      bind_cols(loglik=ll[1],loglik.se=ll[2])
  } -> results
  attr(results,"ncpu") <- nbrOfWorkers()
  results
}) -> results_local

results_local_maxll = results_local |> arrange(desc(loglik)) |> slice(1)
best_params_local = results_local_maxll |> select(b1:N) |> as.list() |> unlist()

cat("[INFO] Local search completed, model dumped to 'local_search.rds'.\n")
cat("[INFO] Best parameters:\n")
setNames(sprintf("%.3f", best_params_local), names(best_params_local))

cat("[INFO] Est. loglik =", round(results_local_maxll["loglik"] |> as.numeric(), 2), " | SE =", 
    round(results_local_maxll["loglik.se"] |> as.numeric(), 4), "\n")

## Plots for local search

(mifs_local |>
  traces() |>
  melt() |>
  ggplot(aes(x=iteration,y=value,group=.L1,color=factor(.L1)))+
  geom_line()+
  guides(color="none")+
  facet_wrap(~name,scales="free_y")) |>
  ggsave(
    filename = "./pic/local_search.png",
    plot = _,
    width = 8,
    height = 5,
    dpi = 300
  )


COVID_SEIR_local <- COVID_SEIR |> pomp(params = best_params_local)

### Check the particle filter

COVID_SEIR_local |> pfilter(Np = 5000) -> p_filter
png("./pic/ess_local.png", width = 800, height = 600)
plot(p_filter)
dev.off()

sim_df_local <- simulate(COVID_SEIR_local, nsim = 5, format = "data.frame") |>
  select(Week_Number, .id, reports) |>
  mutate(source = "Simulated")

(
  bind_rows(sim_df_local, real_df) |>
  ggplot(aes(x = Week_Number, y = reports, color = source)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated vs. Observed Weekly COVID-19 Cases, Local Search Optimal",
    x = "Week",
    y = "Reported Cases",
    color = "Data Source"
  ) +
  theme_minimal()
  ) |>
  ggsave(
    filename = "./pic/sim_local.png",
    plot = _,
    width = 8,
    height = 5,
    dpi = 300
  )

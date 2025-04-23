# We notice that our SEIRS model cannot accurately capture the seasonality of the data even with the incubation period, infection period, and immunity period are reasonable. 
# While not including vaccines, the transmission rate of influenza virus fluctuates seasonally because of humidity, temperature, etc. 
# In addition, the virus undergo antigenic shifts and mutations, which can affect transmission rate and immunity rates. 
# Because influenza has a long infection history, we assume this immunity rate changes (without vaccines) comes from the 
# net effect between human protection developed genetically from previous infections or transmissions and the mutations of the virus.

# -*- coding: UTF-8 -*-

library(tidyverse)
library(dplyr)
library(tidyr)
library(iterators)
library(knitr)
library(foreach)
library(doFuture)
library(pomp)
library(zoo)
library(lubridate)
if (.Platform$OS.type == "windows") {
  options(pomp_cdir="./tmp")
}

# Load from EDA

data = read.csv("ilitotal2015.csv")

# Because CDC has not published the vaccine coverage data of season 2024-2025, we have to curtail the data. From now on we are using 2015-2024 seasons. 

data |> filter(YEAR < 2024) -> data

registerDoFuture()

cores <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
if(is.na(cores) || cores < 1) cores <- parallel::detectCores(logical=FALSE)

plan(multisession, workers=cores)

set.seed(1280094583)

# Time setup

weeks <- row_number(data)
n_weeks <- length(weeks)

# Covariates

# COVID
covid_start <- 271 # Week of 2020-03-09, the US declared a national emergency on 2020-03-13, states begin to implement shutdowns on 2020-03-15
covid_end <- 333 # Week of 2023-05-08, Public Health Emergency for COVID-19, declared under Section 319 of the Public Health Service Act, expires at the end of 2023-05-11

# These times mark the start and end of public suppression of Covid. Keep in mind that it takes time for suppression forces to build up and cool down, and the public suppression is a gradual process. 

# It is better to model suppression level as a smooth curve: 
# Let the suppression began at week 271, and returned to baseline by week 436, we use an asymmetric logistic ramp to model the suppression level
# because individuals were aware of Covid to some degree earlier than governmental actions, and suppression were placed slower than it was lifted 
# This is natural to assume because people need to learn to live under special conditions but can return to normal quickly. 

# Vaccine during COVID

# We model Beta directly since this is the most explicit way instead of modeling R(t)

# Vaccine data

# Load vaccine coverage data (monthly, interpolate to weekly from CDC)
vax_data <- read.csv("Flu_vac_region_5_monthly.csv")

# All data we are interested are assumed to be in sound quality (there are no footnotes (*) associated with any of them). None of the CI's has half width > 2. 
# For all years in the full report, from CDC, there are no June data. This is not an occasional missing value error, but intentionally CDC sees no interest in June vaccine coverage. 
# No one take flu shots that far off infectious season. Thus, we manually add June and set the estimate to 0. 

all_months <- expand.grid(
  Year=unique(vax_data$Year), 
  Month=1:12
)

all_months |> 
  left_join(vax_data, by=c("Year", "Month")) |> 
  mutate(
    Estimate = ifelse(is.na(Estimate), 0, Estimate),
    coverage = Estimate / 100
    ) |>
  arrange(Year, Month) |> 
  mutate(month_index = row_number())-> vax_data

week_index = tibble(t=1:nrow(data))

week_index |> 
  mutate(
    month_position = t/4.348, 
    coverage_interp = approx(x = vax_data$month_index, y = vax_data$coverage, 
                             xout = month_position, rule=2)$y
  ) -> coverage_weekly

# coverage_weekly

write.csv(coverage_weekly, "flu_vac_coverage_region_5_weekly.csv")

# Another important factor that drives the dynamics of vaccination effect is how effective the vaccines are against influenza. The virus change every season, and because different types of flu viruses 
# dominate different years (for example H3(A) circa 2017-2019, and recently H1N1). Although CDC recommend different types of vaccines in different years, the observed vaccine effectiveness (from reports)
# differs greatly among different demographic backgrounds (age groups, especially). This made vaccine effectiveness measurement complicated and unreliable. CDC estimates seasonal flu vaccine effectiveness
# every season, but looking at the CI's, we find that these values are not good enough. Future studies can try to find more reliable sources of vaccine effectiveness. Here we will use these values. 
# Although it is not ideal, but the nature of vaccine - virus battle and the data both indicate that vaccine effectiveness is not constant over the years. Future studies can try to model effectiveness, 
# but this is not our focus. 

# "2020-2021 flu vaccine effectiveness was not estimated due to low influenza virus circulation during the 2020-2021 flu season". We set it to a moderate value (doesn't matter because there was COVID): 

ve_annual <- read.csv("vaccine-effectiveness.csv")

ve_annual |> 
  mutate(ve = VE / 100, season_index = row_number()) -> ve_annual

weeks_per_season <- floor(n_weeks / nrow(ve_annual))
ve_weekly <- rep(ve_annual$ve, each = weeks_per_season)
remainder <- n_weeks - length(ve_weekly)
if (remainder > 0) {
  ve_weekly <- c(ve_weekly, rep(tail(ve_weekly, 1), remainder))
}

write.csv(ve_weekly, "ve_weekly.csv")

# Covariate table

covar_df <- tibble(
  time = weeks,
  nu0 = as.numeric(coverage_weekly$coverage_interp),
  VE = as.numeric(ve_weekly)
)

# Pad t=0 explicitly and make sure values are numeric and not NA
if (min(covar_df$time) > 0 || covar_df$time[1] != 0) {
  covar_df <- bind_rows(
    tibble(
      time = 0,
      nu0 = covar_df$nu0[1],
      VE = covar_df$VE[1]
    ),
    covar_df
  )
}

covar <- covariate_table(covar_df, times = "time")

test <- coverage_weekly$coverage_interp
# SEIRS model with seasonal transmission rate, covid suppression, vaccine effects, and antigenic drifts

seirs_step <- Csnippet("
  double covid_start = 271; // from COVID above
  double covid_end = 333;
  double onset = 1.0 / (1.0 + exp(-r1 * (t - covid_start)));
  double offset = 1.0 / (1.0 + exp(-r2 * (t - covid_end)));
  double covid_effect = 1 - A * (onset - offset); // dynamic suppression
  
  double seasonal_phase = 2 * M_PI * t / 52 - phase;
  double Beta_seasonal = Beta0 * (1 + Beta1 * cos(seasonal_phase)); //seasonal beta with cos function
  
  x += rnorm(0, sigma_mut * sqrt(dt)); // antigenic drift H1N1 0.5-1 units per year; H3N2 1-3 units per year; modeled as BM
  
  if (fabs(fmod(t, 52.0)) < 1e-2) {
  x_ref = x;
  } // annual reset of reference strain 
  
  double antigenic_distance = fabs(x - x_ref);
  double antigenic_effect = exp(alpha * fmin(10.0, antigenic_distance)); 
  // This means as antigenic distance grows, Beta_t increases exponentially (approximating the increase in susceptibility and loss of protection). 
  
  double nu = nu0; //from covariate
  double VE_eff = VE; //from covariate
  double S_eff = fmax(0, S * (1 - nu * VE_eff)); //VE from covariate
  
  double Beta_t = Beta_seasonal * antigenic_effect * covid_effect; // models how transmission rate is affected by immune escape due to antigenic drifts and Covid
  double mu_RS_t = mu_RS * (1 + gamma * antigenic_distance); // linear changes the waning rate of immunity depending on how far the drift is away from the original exposure (loss of natural immunity)
  
  double p_inf = fmax(0.0, fmin(1 - exp(-Beta_t * I / N * dt), 1.0));
  double p_EI  = 1 - exp(-mu_EI * dt);
  double p_IR  = 1 - exp(-mu_IR * dt);
  double p_RS  = 1 - exp(-mu_RS_t * dt);
  
  double dN_SE = rbinom(nearbyint(S_eff), p_inf); // stuck here for 3 hours... S_eff is double and that blowed rbinom up... 
  double dN_EI = rbinom(E, p_EI);
  double dN_IR = rbinom(I, p_IR);
  double dN_RS = rbinom(R, p_RS);
  
  S += dN_RS - dN_SE;
  E += dN_SE - dN_EI;
  I += dN_EI - dN_IR;
  if (I < 10) {
    double imported = rpois(0.2); 
    I += imported;
    H += imported;
  } // (really) mild imported infectious cases (add stochasticity, especially to restart the pandemic!)
  R += dN_IR - dN_RS;
  H += dN_EI;
  
  
  
  if (fabs(fmod(t, 1.0)) < 1e-8) {
  H = 0;
  } // resets H = 0 

") # H tracks incident symptomatic cases, consistent with ILI report definitions

# Intialization: We initialize the population of each state in a more complicated yet consistent way. First note that we start in the middle of a flu season (January), 
# so we assume eta proportion of the population is infectious or in incubation. We note that the data, ilitotal, is a symptom-based data, which our design of H (accumulates with dN_EI) reflects this point. 
# As an accumulator, H will be initialized to 0 and reset every season. However, we cannot initialize E to 0 of we want a better fit at the beginning, and it is consistent with the situation at the start. 
# We have to initialize E as a nonzero value, reflecting the fact that we start in the middle of a season, and allowing H to be accumulated right at the start for better fit. 
# Question: N is the total population, and N = S + E + I + R unless someone landed from Mars. How do we define the initial proportion of incubation and infectious? 
# Solution: We still set eta * N of people in E and I, and weight the proportion of E and I based on basic probability theories: 

seirs_init <- Csnippet("
  double dur_E = 1.0 / mu_EI;
  double dur_I = 1.0 / mu_IR; // Consistency! 
  
  double prop_E = dur_E / (dur_E + dur_I); // in the middle of a flu season, the proportion of incubation virus-carrying pop
  double prop_I = 1.0 - prop_E; // in the middle of a flu season, the proportion of infectious virus-carrying people
  
  double eta_total = eta * N; // Now eta is the proportion of people who carry the virus
  
  E = nearbyint(eta_total*prop_E); 
  I = nearbyint(eta_total*prop_I);
  R = 0; // Immunity is implicitly modeled by beta and mu_RS, so this is 0 (fine), and don't want any more parameters (limits)
  S = N - E - I;
  H = 0;
  x = 0;
  x_ref = 0;
")

dmeas <- Csnippet("
  double mean = (rho * H < 1) ? 1 : rho * H;
  lik = dnbinom_mu(reports,k,mean,give_log);
")

rmeas <- Csnippet("
  reports = rnbinom_mu(k,rho*H);
")

data |> select(reports = ILITOTAL) |> 
  pomp(
    times=row_number(data), t0 = 0,
    rprocess=euler(seirs_step,delta.t=1/7),
    rinit=seirs_init,
    rmeasure=rmeas,
    dmeasure=dmeas,
    accumvars="H",
    covar = covar,
    covarnames = c("nu0", "VE"),
    statenames = c("S", "E", "I", "R", "H", "x", "x_ref"), 
    paramnames = c(
      "Beta0", "Beta1", "phase",
      "mu_EI", "mu_IR", "mu_RS",
      "rho", "eta", "k", "N",
      "alpha", "gamma", "sigma_mut", "A", "r1", "r2"
    ),
    partrans=parameter_trans(
      log=c("Beta0", "Beta1", "mu_EI", "mu_IR", "mu_RS", "k", "sigma_mut", "alpha", "gamma"), 
      logit=c("rho", "eta", "A")
    ),
    params = c(
      N = 52900000,      # population of HHS region 5 (fixed)
      Beta0 = 1.8,       # baseline transmission rate
      Beta1 = 0.15,       # seasonal forcing amplitude
      phase = 0.2,       # seasonal peak (e.g. week 0 = January) fixed to week 10, clear trend
      mu_EI = 3.5,       # exposed b infectious (1/7 week = 1 day) CDC: 1-4 days, fixed to 2 days (CDC estimated average)
      mu_IR = 1.6,       # infectious b recovered (default = 5 days, CDC estimated typical)
      mu_RS = 0.1,      # waning immunity (1/0.05 = 20 weeks)
      rho = 0.35,        # reporting rate
      eta = 0.00015,      # initial carrying %
      alpha = 7,       # antigenic impact on Beta
      gamma = 5,       # antigenic impact on immunity waning
      sigma_mut = 0.01,  # antigenic drift (volatility), fixed (not enough data and not doing deep evolutionary analysis)
      A = 0.15,           # Covid suppression coefs, this matters! 
      r1 = 0.15,         # fixed, not enough data
      r2 = 0.25,         # fixed, not enough data
      k = 10             # overdispersion (fixed)
    )
  ) -> flu_seirs_bvgc # Beta, vaccine, genetic mutation, covid

# # Sanity check
# 
# sim <- simulate(flu_seirs_bvgc, nsim = 1, t0 = -1, format="data.frame", include.data=TRUE)
# 
# sim |>
#   filter(.id != "data") |>
#   pivot_longer(cols = c(S, E, I, R, H, x, x_ref), names_to = "compartment") |>
#   ggplot(aes(x = time, y = value, color = compartment)) +
#   geom_line()
# 
# sim |>
#   ggplot(aes(x=time,y=reports,group=.id,color=.id=="data"))+
#   geom_line()+
#   guides(color="none")
# 
# foreach(i=1:10,.combine=c,
#         .options.future=list(seed=TRUE)
# ) %dofuture% {
#   flu_seirs_bvgc |> pfilter(Np=5000)
# } -> pf
# pf |> logLik() |> logmeanexp(se=TRUE) -> L_pf
# L_pf
# 
# flu_seirs_bvgc |>
#   pfilter(Np=5000) -> pf
# plot(pf)
# 
# # Local search
# 
# if (file.exists("bvgcseirs_local_search_final.rds")) {
#   file.remove("bvgcseirs_local_search_final.rds")
# }
# 
# bake(file="bvgcseirs_local_search_final.rds",{
#   foreach(i=1:20,.combine=c,
#           .options.future=list(seed=482947940)
#   ) %dofuture% {
#     flu_seirs_bvgc |>
#       mif2(
#         Np=5000, Nmif=50,
#         cooling.fraction.50=0.5,
#         rw.sd=rw_sd(Beta0=0.02, Beta1 = 0.02, phase=0.02, mu_IR = 0.02, mu_RS = 0.02, rho=0.02, eta=ivp(0.02), alpha = 0.05, gamma = 0.05, A=0.02)
#       )
#   } -> seirs_mifs_local
#   seirs_mifs_local
# }) -> seirs_mifs_local
# 
# if (file.exists("bvgcseirs_local_loglik_final.rds")) {
#   file.remove("bvgcseirs_local_loglik_final.rds")
# }
# 
# bake(file="bvgcseirs_local_loglik_final.rds", {
#   foreach(mf=seirs_mifs_local,.combine=rbind,
#           .options.future=list(seed=900242057)
#   ) %dofuture% {
#     evals <- replicate(10, logLik(pfilter(mf,Np=5000)))
#     ll <- logmeanexp(evals,se=TRUE)
#     mf |> coef() |> bind_rows() |>
#       bind_cols(loglik=ll[1],loglik.se=ll[2], Np=2000, nfilt=10)
#   }
# }) -> local_loglik

# Global search
# Based on previous local searches

seirs_mifs_local <- readRDS("bvgcseirs_local_search_final.rds")
mf1 <- seirs_mifs_local[[1]]
# coef(mf1)
# coef(mf1) <- c(Beta0=2.0, Beta1=0.2, phase=0.0, eta=0.005, rho=0.2, alpha=5, gamma=0.5, mu_IR=1.0, mu_RS=0.1, A=0.02, k=10, r1=0.15, r2=0.25, sigma_mut=0.01, mu_EI=3.5, N=52900000)

fixed_params <- c(N=52900000, k=10, r1=0.15, r2=0.25, sigma_mut=0.14, phase=0.0, mu_EI=3.5, alpha=0.33, rho=0.036)

guesses <- runif_design(
  lower = c(
    Beta0 = 0.5, Beta1 = 0.05,
    mu_IR = 0.5, mu_RS = 0.01,
    eta = 1e-5,
    gamma = 0.1, A = 0.01
  ),
  upper = c(
    Beta0 = 3.0, Beta1 = 0.5,
    mu_IR = 3.0, mu_RS = 0.2,
    eta = 1e-2,
    gamma = 10, A = 0.3
  ),
  nseq = 200
)

bake(file="bvgcseirs_global_search_frhoalpha.rds", {
  foreach(guess=iter(guesses,"row"), .combine=rbind,
          .options.future=list(seed=TRUE) ) %dofuture% {
            mf1 |>
              mif2(
                params=c(guess,fixed_params),
                rw.sd = rw_sd(
                  Beta0 = 0.01,
                  Beta1 = 0.01,
                  mu_IR = 0.01,
                  mu_RS = 0.005,
                  eta = ivp(0.01),
                  gamma = 0.005,
                  A = 0.01
                ),
                Np = 2000, Nmif = 50,
                cooling.fraction.50 = 0.5
              ) |>
              mif2(Nmif=50)-> mf
            replicate(
              10,
              mf |> pfilter(Np=5000) |> logLik()
            ) |>
              logmeanexp(se=TRUE)-> ll
            mf |> coef() |> bind_rows() |>
              bind_cols(loglik=ll[1],loglik.se=ll[2]) }
}) -> seirs_mifs_global

# Poor man's profile for alpha

# global_results <- readRDS("bvgcseirs_global_search_frho.rds")
# global_results |>
#   filter(is.finite(loglik), loglik == max(loglik, na.rm = TRUE)) -> best_params
# 
# theta <- best_params |>
#   select(-loglik, -loglik.se) |>
#   as.list() |> unlist()
# 
# alpha_grid <- seq(0.01, 0.7, by=0.02)
# 
# registerDoFuture()
# plan(multisession, workers=parallel::detectCores())
# 
# bake(file="poor_profile_alpha_frho_extended.rds", {
#   foreach(a = alpha_grid, .combine = bind_rows,
#           .options.future = list(seed = TRUE)) %dopar% {
#             theta_cur <- theta
#             theta_cur["alpha"] <- a
# 
#             mf <- mif2(
#               flu_seirs_bvgc,
#               params = theta_cur,
#               Np = 2000, Nmif = 50,
#               cooling.fraction.50 = 0.5,
#               rw.sd = rw_sd(Beta0=0.01, Beta1=0.01, gamma=0.01, mu_RS=0.01, mu_IR=0.01)
#             )
# 
#             ll <- replicate(10, logLik(pfilter(mf, Np = 5000))) |> logmeanexp(se = TRUE)
#             as_tibble_row(coef(mf)) |> mutate(loglik = ll[1], loglik.se = ll[2])
#           }
# }) -> poor_profile_alpha
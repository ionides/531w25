---
title: "Subramanian, He & Pascual (2021)."
date: "Apr 10, 2025"
output:
  ioslides_presentation:
    smaller: no
    widescreen: true
    transition: "faster" 
---

## Impact

* Cited 270 times. 

* Many COVID data analysis papers were published in 2021.

* This one is unusual for incorporating stochastic transmission dynamics, time-varying testing, hospital case and serology data, and formal statistical inference.

## The model

* Fig 1 (overall flow) elaborated as a set of differential equations in Sec. S1.

* Actual model code is at [https://github.com/pascualgroup/COVID_NYC_Epi_Model](https://github.com/pascualgroup/COVID_NYC_Epi_Model/blob/master/Code/Csnippet_nyc_coronavirus_model_N_12.R)

* The actual model has equidispersed multinomial dynamics (i.e., no overdispersion).

* It is not unusual to write equations for a deterministic model and implement a stochastic one.
    + What are the advantages/disadvantages/risks of doing this?

## The data

* Syndrome surveillance data from NYC hospital emergency departments and observed influenza cases in NYC in previous years.

* Early in the epidemic, it is critical to estimate the non-COVID background of influenza-like illness that obscured the initial growth of COVID.

* The COVID test allocation protocol is modeled.

## Inference

* A very large number of starting values ($25 \times 10^3$) are used for global optimization.

* Parameter sets with comparable likelihood to the maximum (within 2 log units) were compared against an independent NYC serology survey. The final model was therefore required to be consistent with both.
    + How does this compare with alternative approaches to incorporating cross-sectional data with time series data?






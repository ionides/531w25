---
title: "Review comments on Final Project 14"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* A careful analysis of influenza. The analysis builds on previous projects, but pays additional attention to loss of immunity, an important feature of flu transmission dynamics.

* Plotting, ACF, spectral analysis and ARMA are all best done on a log scale. Then, the log-ARMA likelihood needs to be computed with care (see the measles case study in Chapter 18).

* The project acknowledges building on two previous projects on flu in [Oklahoma (W24 #5)](https://ionides.github.io/531w24/final_project/project05/blinded.html) and [aggregated for USA (W22 #43)](https://ionides.github.io/531w22/final_project/project20/blinded.html#43_Particle_filter_and_likelihood_for_intial_guess). The project makes a clear statement about how it progresses beyond these previous projects, for example, by including profile likelihood plots. However, there are other 531 projects on flu with profiles, e.g., [W24 #16](https://ionides.github.io/531w24/final_project/project16/blinded.html). Review of past 531 work on flu could have been more complete, but readers were satisfied that this project goes beyond previous work in ways other than just using a different dataset.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Formally, it is incorrect to say  "a strong autocorrelation at lag one that decays gradually across subsequent lags indicates a non-stationary time series". The usual motivation for the sample ACF assumes a stationary model. The rate of decay in that case just depends on the timescale of dependence.

* There is some confusion in: "The ODEs can be solved by Euler’s numerical method. Specifically, the RHS can be expressed as a binomial approximation with exponential transition probability". The ODE model and stochastic models are different things.

* The main value of ARMA is probably to provide a benchmark to check when the mechanistic model is becoming well specified. The ARMA likelihood is not discussed in this context (and is not presented, though it can be back-calculated from the reported AIC).






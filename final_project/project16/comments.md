---
title: "Review comments on Final Project 16"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* Some originality in choice of dataset and in the decision to try ARCH for a epidemiological model. That would normally be unrecommended, but here it is found to do okay.

* Plotting, ACF, spectral analysis and ARMA are all best done on a log scale. Then, the log-ARMA likelihood needs to be computed with care (see the measles case study in Chapter 18).

* Here, your reporting rate is estimated to be close to one. There is no depletion of susceptibles, since cases are much less than the $N=48 \times 10^6$. This particular mechanistic model is not doing a good job. The real reporting rate for pertussis is probably very low, since mild or asymptomatic infections are common.

* The implemented SEIR model has no overdispersion in the process model. Also, no seasonality. There are various things to try to fix it up. The main contribution of the benchmark likelihoods is to remind us that the mechanistic model is not fully effective yet, and needs more work. However, multiple cycles of model development may not be possible on the timescale of a 531 final project.

* Given the identified problems with the mechanistic model, it would be good to provide diagnostic plots (effective sample size, likelihood anomalies, etc). Without these, it is difficult to assess whether the POMP models failed due to misspecification, poor initialization, or numerical instability.

### Minor points (strengths or weaknesses or errors or potential improvements)

* ARCH is quite an unintuitive model for epidemics; it makes sense when the conditional mean is always constant, i.e., when the integrated process is random variation around exponential growth.

* For comparing SEIR with ARCH, likelihood is a better measure than relying on a few hold-out timepoints.

* It's nice to notice the almost-comparability of the log-liks between the ARCH for differences and the SEIR: "Since first differencing is a linear transformation with a constant Jacobian, we can directly compare these fits after accounting for the dropped initial term."

* section/equation/figure numbers would be helpful to the reader.


* The report would benefit from a consolidated summary table showing model type, log-likelihood, parameter estimates, and perhaps notes on model stability or convergence. 





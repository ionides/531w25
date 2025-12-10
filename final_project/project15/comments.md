---
title: "Review comments on Final Project 15"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* The t-distribution for stochastic volatility models (Breto and Heston) is a good innovation. 

* Why is GARCH selected by log-likelihood not AIC? And, are you sure the software is reporting the actual likelihood not some approximation? We saw in class (Quiz 2, Q12-02) that quantities called log-likelihood for GARCH software are sometimes not exactly the log-likeliohood. It would be worth saying how you know your numbers are correct.

* Fig. 7 shows long tails, not "adequate except for slight heavy‑tail deviations." Trying a t-distributed GARCH would lead to substantial improvement, as the project later finds for stochastic volatility.

### Minor points (strengths or weaknesses or errors or potential improvements)

* The figures and sections are conveniently numbered for reference

* Note that the GARCH log-likelihoods do not satisfy nesting. Mathematically, e.g., (p,q)=(3,2) includes (3,1) so should not have a lower maximized likelihood.

* Interestingly, with the t-disribution, the likelihood does not decrease through iterations, at least for the better mode.

* Various models are investigated, and it would be nice to have more direct comparison. At least, a table with all the likelihoods. Perhaps also some analysis of conditional log-likelihoods at each time pointwhich time point to see which observations the models differ on.

* "Even though we cannot directly compare loglikelihood from tseries::garch [12], we can still argue that GARCH(3,1) is the most promising one" could be confusing. Is this calculated conditionally on some iniital data? It needs explanation to say something is wrong but we use it anyway.






---
title: "Review comments on Final Project 12"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)


* In Sec. 2.2. the ADF test is not appropriate to examine non-stationary variance.

* ARMA is described as modeling "key autocorrelation patterns" but the sample ACF and the AIC table show that the key here is that there are no evident autocorrelation patterns.

* The likelihood values are quite close. We saw in class (Quiz 2, Q12-02) that quantities called log-likelihood for GARCH software are sometimes not exactly the log-likelihood. It would be worth saying how you know the GARCH likelihood is actually a likelihood not a conditional likelihood of some kind.

* The advantage of the POMP framework is that it easily allows you to use crativity to improve the model. For example, it is easy to stick a t-distribution into the measurement model. There is a missed opportunity to use that creativity for the return distribution, which is very simple to code and various other groups did it for similar situations.

* This group did attempt some novelty, taking advantage of the flexibility of the POMP framework to test out a switching model. However, that does not help much, and they note that modeling longer tails might be more important.

### Minor points (strengths or weaknesses or errors or potential improvements)

* "The ACF of squared residuals does not show significant spikes after lag1". Various uninformative plots of ARMA residuals are shown, but this potentially informative one is not.

* "This log-likelihood [of the stochastic volatility (SV) model] is notably higher than our ARIMA and GARCH benchmarks" : this is true except for the t-distributed GARCH model. That suggests including a t-distribution in the SV model.

* The GARCH AIC values in Table 3 are not quite mathematically consistent. This should be noted, and the consequences of imperfect maximiation should be discussed.

* The Table 3 lowest AIC value is referenced as -5046.13 in the text, but that number does not appear in the table.






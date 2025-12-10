---
title: "Review comments on Final Project 8"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)


* The ADF test is not designed to look for non-stationary variance which is the main issue here. Indeed, the assertion "we reject the null hypothesis of a unit root and conclude that the series are stationary" is a classic example of false reasoning. Not all processes without a unit root are stationary. This logical flaw has consequences for time series analysis that we have encountered multiple times this semester.

* There is a weakly supported assertion that, "The ARIMA(2,0,2) model captures NFLX’s complex dynamics, balancing autoregressive (AR) and moving average (MA) components to account for its volatile behavior. This structure reflects the stock’s sensitivity to external shocks and momentum effects." The ARIMA model cannot explain the volatility dynamics.

* Various ARMA models are fitted, but not compared against the null (white noise). The larger ARMA models probably have roots close to canceling. We have seen in the course that log-returns are close to uncorrelated, so for a linear Gaussian model they are inferred (incorrectly) to be approximately independent.

### Minor points (strengths or weaknesses or errors or potential improvements)

* The asymmetric t-distribution for GARCH looks like a suitable model, judged by likelihood. More could be said about contrasting these different models.

* The quantmod package looks like a good resource for finance data

* Are there other companies with less volatility that the overall market:  "NFLX consistently exhibits higher volatility than SPY, reflecting its sensitivity to company-specific factors compared to the broader market." It seems like the aggregate should (almost) necessarily have lower variability.

* Section 7 is unrelated to course material and doesn't contribute to the model development issues in earler sections.

* The model fit of the mechanistic and non-mechanistic models could be compared, e.g., by AIC. One can also compare conditional log-likelihoods of individual observations to see in which parts of the dataset the mechanistic hypothesis is (and is not) helpful.

* Figure numbers and captions would help the reader.

* All the time spend on ARMA doesn't make much sense when GARCH models and POMP models. Better to spend additional time on those, looking at additional diagnostics for the models of most interest.

* The identified points with low effective sample size may indicate a longer-tailed distribution is needed to fit the returns.






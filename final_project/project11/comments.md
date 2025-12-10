---
title: "Review comments on Final Project 11"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* Reviewers reported successful reproduction of the results from the code and data provided.

* Are the GARCH quantitites called "likelihood" actually likelihoods or just somethihg similar? See Quiz 2, Q12-02.

* "despite having the lowest log-likelihood, sGARCH-norm achieves the lowest AIC due to its simpler structure" : this doesn't look right, because 30 units of log likelihood would require an additional 30 parameters if it is not to have a higher AIC.

* The t distribution can be used for stochastic volatility models just as readily as for GARCH models. It is good for non-mechanistic and mechanistic models to challenge each other for new ideas. But, the insights from them can and should be included in the mechanistic models.

* The conclusion, "ARMA modeling is crucial for capturing autocorrelation structures in financial time series" is not clearly supported. Essentially no autocorrelation is found, and then the analysis moves on to GARCH models which assume the autocorrelation is zero.

* Most of this project could have been done as a midterm project. There are many past midterm and final projects doing similar things, so the analysis is quite routine. The stochastic volatility part is not well developed: an existing model is used, and weaknesses are not fixed.

* Although the author acknowledges the poor convergence in the local search, they have decided to use 1000 particles with 50 iterations. Maybe it’s worth trying more particles and more iterations. (something like 5000 particles and 100 iterations) This way, they may be able to see if it’s the problem with particle filtering or if there is model misspecification.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Fig 3.1 has a caption: "density of gold prices". Also, a histogram of marginal values of a time series is usually not a good idea. When the time series has a trend, it is an especially poor choice.

* The sample ACF of index prices is uninformative. This plot estimates autocorrelation for a stationary time series, but the time plot (and common knowledge of investments) suggests that it is close to a random walk, which is non-stationary.

* The reason given for choosing ARMA(1,1) is parsimony, but (1,0) and (0,1) have better AIC and more parsimony.

* Quite a long time is spent on ARMA considering that it gets discarded in favor of better models.

* From a referee with some relevant domain knowledge: Firstly, the team decided to use the close price rather than the adjusted close price. This is fine if there were no stock splits for the duration of their chosen time (January 2020 onward). However, on August 28, 2020, a stock split occurred. This would cause the raw close price not accurately to reflect market fluctuations. The report wrote, "A major shift occurred in 2020, marked by a rapid surge in prices and increased volatility." This is likely due to the use of the raw closing price as affected by the stock split.








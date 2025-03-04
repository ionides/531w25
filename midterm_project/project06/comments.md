---
title: "Review comments on Project 6"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. Interestingly, no evidence is found for conditional heteroskedasticity. That may be because the data analyzed are monthly, and changes in variation in the stock market occur on shorter timescales. So, if your investing horizon is on the timescale of months, a random walk model may be sufficient.

1. The contribution of this project is well placed in the context of previous midterm projects.

1. Section numbers, figure labels, and a good balance between numerical results, figures and text, make this project easy to read. 

### Specific comments

1. EDA would be done better on the log scale. Percentage changes are relevant. Otherwise, the decompositions, etc, suffer from severe heteroskedasticity.

1. Log-differencing is the right thing to do here, not just because differencing is a common way to try to transform to stationarity, but because financial theory suggests the log-difference is a meaningful quantity (the return).

1. The use of `auto.arima()` to trouble-shoot numerical problems with `arima()` is problematitic: `auto.arima` calls `arima` for its maximization, so any problems are still there but just remain hidden. Nevertheless, `auto.arima` also avoids models with roots close to the unit circle, so it chooses ARMA(0,0) here.

1. The report's explanation of `auto.arima` suggests that it looks for the lowest AIC value, but we see from the table that lower AIC values exist. Is it a failure of AIC that it didn't find these values, or is it looking for something other than AIC?

1. In Section 3.6, what is the likelihood ratio test being conducted on? One can go into the code to find out: it's a regression on Bitcoin return with ARMA errors, in fact white noise since it is ARMA(0,0), and the test is for contemporaneous NASDAQ return as a covariate. Also, 7 significant figures is too much for a p-value.

1. Spectral analysis might be clearer on the returns rather than the original data (similarly, the sample ACF). The Bitcoin sample ACF for returns suggests that there may be some identifiable periodicity that could be clearer in the frequency domain, though you might just see white noise. 

1. In Fig 7, the sample ACF is interpreted as evidence for non-stationarity. The sample ACF estimates autocorrelaton under an assumption of stationarity, so it is not a good way to assess stationarity itself. A time plot is better for that.

1. Sometimes Bitcoin and NASDAQ are treated symmetrically, sometimes NASDAQ is studied as an explanatory variable for Bitcoin. The reasons for these two perspectives, and the transitions between them, could be explained more clearly. 

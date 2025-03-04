---
title: "Review comments on Project 10"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. Clear statement about relationship to past projects. This project says it does not use any previous code or results, but it would have been appropriate to use some (properly cited) if they benefitted the project.

1. The use of financial models for inflation is somewhat unusual (and therefore interesting). The references support this as a reasonable idea. Unfortunately, multiple models and corresponding software are introduced rather briefly, and in at least some situations it seems that the numbers produced by these programs are not fully understood (for example, different programs may have different quantities called AIC)

1. Rolling window validation investigated in Sec 5.1 is a good idea, though 
Sec 5.2 returns to a simple single-split investigation, somewhat diluting the contribution.

1. The description of libraries used is an interesting addition, not previously seen in 531 projects.

1. The code is reproducible. As a small detail, the random number seed could be set using `set.seed()` to make it fully reproducible.


### Specific comments

1. The reasoning of "because the base year of CPI data from FRED is 1982-1984" is hard to follow because the choice of base year just provides a relative scaling, so it should not have substantial importance. The point about changes in the basket is well made, but also impossible to avoid even since 1985. Cell phones and internet provider contracts were not a common expense before 2000, for example.

1. The Box-Ljung test here is not very informative beyond what has already been shown clearly from the ACF plot. Box-Ljung can be helpful when there are many lags close to significance and we are wondering if their cumulative evidence is compelling.

1. The periodogram assessment looks wrong: "This analysis provides strong support for seasonal models." There are dips at the seasonal frequencies (integer cycles per year). This suggests that the data are already deseasonalized. Ideal deseasonalization might lead to smooth variation, rather than dips. 

1. The exact source of the data is not given, so we can't check if it is deseasonalized without digging into the code and examining `getSymbols("CPIAUCSL", src = "FRED")`.

1. Much space is spent on explaining Shapiro-Wilk and Jarque-Bera tests which are not very useful here. There is massive deviation from normality, and the QQ-plot is more informative for looking at the nature of this deviation.  Shapiro-Wilk and Jarque-Bera could be helpful if we are unsure about the significance of the QQ-plot deviation.

1. The rationale for ARMA(2,0) is unclear since ARMA(4,2) has lower AIC. The choice of ARMA(2,0) is reasonable, since probably ARMA(4,2) has roots very close to the unit circle and close to canceling.

1. It appears that AIC values are compared across different levels of differencing, which is problematic.

1. "SARIMA-GARCH achieves an AIC of -0.4401 and a BIC of -0.3726." Apparently, this is computed on a different scale from the usual -2 loglik + 2p. Please explain.

1. When AIC and log-likelihood values are compared, it becomes critical that they are computed with an equivalent meaning (e.g., if they all follow the standard definition in the 531 notes). This is unclear here.

1. Many models are introduced throughout the project and are not all explained.

1. Section 5.3 discusses CPI as though it were a stock index. This is an interesting perspective, but the extent to which this is valid should be discussed.

1. The excessive use of bold-face is distracting. It is not good professional style, and its association with ChatGPT (which may not be warranted in this case) is unfortunate.

1. A minor point: There are some typos that could benefit from proof-reading.

1. The Ljung-Box method is introduced, but the plot shown is used to support the obvious fact that the original data are not close to white noise,  

1. There is inconsistency about whether to include a linear trend; sometimes it is described as insignificant, sometimes it is found to be significant. The team should work out which is the best evidence, and explain their conclusion.


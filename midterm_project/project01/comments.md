---
title: "Review comments on Project 1"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. A reasonable selection of three questions.

1. A new source of time series data from the Bureau of Transportation Statistics, with careful documentation of how the dataset was derived.

1. A good decision to put some extra technical details in an appendix.

1. The results are reproducible from the provided code.

1. The project's contribution is placed in the context of previous 531 projects.

### Specific comments

1. "The p-value of the ADF test for the weekly delays is 0.0484, indicating that the weekly time series data is stationary, and that we do not need to apply differencing before proceeding with time series modeling." This assertion is problematic at various levels: (i) the p-value is below 0.05 and the previous paragraph stated an intention to use a size of 0.05; (ii) the data may be better explained by a model with trend rather than a random walk model.

1. "To more formally test for periodicity, we use the stl function". But this assumes seasonality rather than testing for it. 

1. "We see both positive and negative fluctuations around the trend line," This is a mathematical necessity not an insight. The trend line will always pass through the center of the data.

1. "Difference of 2.11 could be due to model complexity". Not quite; it is mathematically impossible for this to be explained by nested pareters.

1. The choice of ARMA model is not sufficiently defended. They chose ARMA(1,1) since it had a reasonable AIC, despite the fact that ARMA(3,1) had a better AIC. Their preference for a simpler model makes some sense but would have been strengthened by more explanation. For instance, why didn’t they do a likelihood ratio test? They also could have plotted the roots of the ARMA(3,1). If one of them was on the border of the unit circle that would have been a stronger argument in favor of the ARMA(1,1) model.

1. Since forecasting was a stated goal of the project, it would be good to include forecasts in the project.


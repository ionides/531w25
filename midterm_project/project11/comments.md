---
title: "Review comments on Project 11"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

The team has access to some interesting data. However,  more details about this should be provided; readers will understand that some data cannot be made public, but it is confusing when this is not explained.

### Specific comments

1. While we understand that the dataset and code cannot be shared due to organizational policy, we recommend that the authors provide a reference or credit indicating the source of the data. Additionally, it would be helpful to include basic details about the dataset, such as the number of observations analyzed, the time period covered (from what is inferred from the time plot, likely Feb 01 – Feb 06), and the geographic context of the noise level measurements. If specific location names cannot be disclosed due to restrictions, providing general characteristics—--such as whether the data was collected in an urban, suburban, or rural environment—--would offer valuable context. This additional information would enhance the audience’s understanding of how environmental noise levels vary across different geographic settings and contribute to a more meaningful interpretation of the temporal trends.

1. The time plot is explained to show changing variance and no trend. Actually, the daily periodicity is the main feature.

1. If variability seemed to be changing, the ADF test carried out would not be an appropriate way to check that. Differencing would not remove heteroskedasticity.

1. A stationary test for strongly periodic data needs care - is ADF appropriate here? ADF tests a specific null hypothesis concerning a unit root and should not be used as a “black box” test for stationarity.

1. The ADF test is not only inappropriate here, but also misinterpreted. It's formal interpretation of the p-value of 0.137 is to reject the null, often misinterpreted to mean an inference of stationarity, but the team interprets this as evidence for non-stationarity and proceeds to take the difference.

1. "Long-term change" is used to describe change within days, say due to weekends.

1. "Daily or other cyclic influences" : check whether periodicity aligns with days.

1. ADF test for seasonal differences is a classic case of how not to use ADF. There is a clear trend (in fact, clearer in this case than in the original data) but ADF picks stationarity rather than the null proposal of a simple unit root model which does describe this situation well.

1. "ACF of differenced Leq" is poorly labeled - you have to see from the code that this is seasonally differenced not the usual first order difference considered earlier in this project.

1. "auto.arima selects the best-fitting ARIMA model". This delegates to `auto.arima` the task of deciding what is best. It is better to investigate that yourself. The `auto.arima` code here used KPSS not ADF for its unit root test, but that is not mentioned.

1. The project discusses different information critera that `auto.arima` might use, but it would be better to discuss more concretely what was actually done.

1. "The best-selected model is SARIMA(2,0,1)". This is not a SARIMA model, just an ARIMA. Perhaps auto.arima was not told the periodicity (144 datapoints) so it looked for something else (12, perhaps) and decided there was none.

1. There is remaining daily periodicity evident from the residual timeplot. The Box-Ljung statistic is perhaps trying to suggest that more attention is needed, by rejecting the null hypothesis of uncorrelated errors, but this is ignored by the team. Indeed, the Ljung-Box test is presented but not explained or discussed. A frequency domain analysis of residuals would be a better way to see this.

1. The residuals are long-tailed. They are centered on zero by mathematical construction so the team is wrong to argue that this is evidence of model fit.

1. The conclusion claim to have found that differencing is necessary, but the proposed model (claimed to be "best") does not have differencing.

1. The conclusion claims to show the need for seasonal modeling, but the proposed model (claimed to be "best") does not have a seasonal component.

1. The rationale for Shapiro-Wilk is a good example of why this test is often a waste of time. The non-normality is obvious from the QQ-plot, and the main question is what to do about it. Being told that the p-value is $10^{-16}$ does not help because the null hypothesis (normality) is already implausible at this point.

1. The project is missing the requested comparison to other past 531 projects.

1. The conclusions do not make any clear contribution to the original questions. Finding that environmental noise has a daily periodicity is not surprising. The ADF test does not show that differencing is necessary before fitting a stationary model, at best it shows differencing is sufficient (it still may not be the best approach). How will the resulting model "aid in mitigating noise pollution and optimizing urban noise management strategies" as promised in the introduction? That is a big question, but some concrete conjectures would help the reader put the project's contribution into context.

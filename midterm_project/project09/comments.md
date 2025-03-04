---
title: "Review comments on Project 9"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. A clear set of questions, relevant to topics covered in class.

1. Clear motivation for studying data only starting in 2015.

1. Various projects use packaged decompositions such as `stl` and `decompose` without explaining (and perhaps without knowing) what these actually do. This project digs deeper and explains, and justifies the choice of `decompose` vs `stl` in the given context.

1. The choice of log transform is appropriate.

1. The use of rolling cross-validation via `tsCV` is appropriate and well explained. The resulting conclusion - that the regression model worked better for longer time series, and differenced SARMA for shorter time series, is insightful and has a good candidate explanation.

1. A range of appropriately used methods.

1. Thorough contextualization with strengths and weaknesses of previous projects.

1. Referees appreciated the careful coding, including the parallel computation of the AIC table.


### Specific comments

1. For the periodogram, units should be cycles per year, and annual seasonality is the bumps at 1,2,3 cycles per year. This could be seen more clearly after detrending. The maximum, at a frequency of 0.2, corresponds to a longer cycle, or perhaps to trend, which is a larger effect than the relatively small seasonality. 

1. For the AIC table, "mathematically improbable" could be a stronger assertion, "mathematically impossible".

1. Inverse AR roots inside the unit circle show causality, not invertibility.

1. You found a large outlier, which is not so obvious from looking at the raw data. It could be interesting to investigate that further. What was going on at that date? One of the advantages of fitting a model is to identify the rare points that don't fit the model.

1. Plotting the sample ACF before detrending is not insightful - what is learned from this plot? Better to focus on informative figures.

1. The study acknowledges external shocks like the COVID-19 pandemic and mortgage rate changes, but an explicit inclusion of these factors in the models such as exogenous variables in a regression with SARIMA errors could investigate these effects quantitatively.

1. Numbered figure captions would help improve readability and make it easier for readers to reference figures.

1. Macroeconomic covariates could be included via regression with SARIMA errors, potentially offering additional explanatory power.


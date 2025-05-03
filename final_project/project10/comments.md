---
title: "Review comments on Final Project 10"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* A mechanistic model is developed and compared with non-mechanistic benchmarks (ARMA and plain regression). The mechanistic model falls quite a long way short of the behcnmarks, indicating problems with the model that there was insufficient time to fix. That is appropriate progress for a time series final project. It would have been nice to see more diagnostic plots to explore why the proposed dynamic model structure is not (yet) fitting well, for example, looking at the likelihood anomalies as in Chapter 18 (the measles case study)



* The decreasing log-liklihood with iteration is an indication of model misspecification. The proposed solution to use more particles or reduce random walk step size will not help - the problem is exactly that as the random walk step size reduces the model no longer fits so well.

* The report does not place the project securely into the context of other 531 projects (or a broader literature, but that is beyond expectatations for a final project). The topic is original, but the report should say this and the team should say what they learned from previous projects, as requested in the assignment description.

### Minor points (strengths or weaknesses or errors or potential improvements)

* When AIC suggests a very large ARIMA, such as (5,1,6), the data are sometimes telling us to think of alternative model specifications. Here, there is a trend that might be fitted, for example.




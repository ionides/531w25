---
title: "Review comments on Final Project 6"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* The project investigates various papers in the literature and adds a deep learning approoach. The mechanistic model gives most understanding about the dynamics, but too little time was spent on that model compared to ARMA and deep learning. The difficulties experienced with the postulated POMP model need thoughtful diagnostics to figure out how to make both the science and the time series data analysis work together coherently.

* Elaborate modern methods, variational mode decomposition and Neural Basis Expansion Analysis for Time Series, are used. They are assessed by one-step forecasting mean absolute prediction error (MAPE) which the team struggles to compare properly between data transformations. MAPE is not comparable between data transformations for the same reason that log-likelihood is not, except the latter can be properly adjusted using a Jacobian transformation. It can be good to try alternative methods not covered in class, but not at the expense of complete and careful use of appropriate methods studied in detail in class.

* Likelihood is a more efficient inference metric than MAPE if the model is reasonable. A model that beats simple statistical benchmarks is usually good enough for likelihood to become a reasonable criterion. Either way, if team prefered MAPE, they should have calculated MAPE also for the SEIR model.

* This project demonstrates a common mistake where the ADF test is inappropriate and a poor choice. It is clear that the peaks are diminishing through time, indicating nonstationarity. Before taking logs, the model used by ADF is especially inappropriate, but even after taking logs it would be a poor choice. See, for example Quiz 1 question Q1-03.

* "The residual time series plot shows no visible trend or seasonal structure" for ARMA is incorrect.  The time plot of residuals shows extreme heterskedasticity matching seasonal peaks and troughs. The residual diagnostics are trying to remind the team that they should consider a logarithmic transformation.

* The SEIR model should be compared to the ARMA benchmark. The fitted model falls short compared to ARMA by 3760-3603 = 157 log units. This large discrepancy suggests the SEIR model is missing something important.

* The observation that "Many inference runs failed due to particle depletion, numerical overflow, or degeneracy in measurement likelihoods" is typical when the model is a poor fit. The inflexible modeling of seasonality or the lack of overdispersion in the process model may be the issue. Diagnostic checks for the POMP model would help to track this down.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Mean/median summary statistics are not very meaningful for time series with plenty of dynamic variation. Best not to show the summaries, and avoid statements like, "The mean weekly count is approximately 777, and the median is about 763, suggesting the distribution is relatively symmetric with some variability" which are appropriate only when the data are well modeled as independent and identically distributed.

* For comparing ARMA with log-ARMA, a Jacobian calculation can put the log-likelihood and AIC values on the same scale. See, e.g., Chapter 18 (the measles case study).

* The ACF, PACF and Box-Ljung sections for residuals for a large ARMA selected by AIC is almost always uninformative: AIC has already selected a model where there is not much dependence left to be found. It would be better use of space to look at normality of residuals. They would be found to be long-tailed compared to normal, another clue that a log transform is appropriate.

* The Outlook section looks to be produced by GenAI. Various modern methods are listed which have been proposed as alternatives for similar model classes, but do not provide plug-and-play likelihood-based inference. With no references, and no details, these generic assertions are the sort of thing that GenAI could generate.






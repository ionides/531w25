---
title: "Review comments on Final Project 7"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---


### Major points (relevant to the strength or correctness or scope of the conclusions)

* The SARIMA analysis has limitations, but is good enough to provide a reasonable benchmark for comparison to mechanistic models. SARIMA would be better on a log scale.

* The novel mechanistic model is developed until it meets the benchmark and has somewhat plausible simulations and parameter values. More could be done, but this is already a nontrivial accomplishment.

* The report says, "The residuals from the SARIMA model appear to be white noise overall." This is a weak interpretation. The tails are substantially longer than normal. One point could even be considered an outlier. The residuals have a slow trend.

* Infectious disease data (like many other non-negative data types) usually fits linear Gaussian assumptions better after a log transform. We have seen this many times in class and in midterm projects. The team should carry out their linear data analysis on the log scale. 

* It would be worth trying to understand the parameter estimates, since that would lead to insights about what biological interpretation the fitted model is actually proposing. How do they fit with known dengue epidemiology? The value $\rho=4\times 10^{-5}$ might be a useful clue.

### Minor points (strengths or weaknesses or errors or potential improvements)

* The two year data period is okay for studying high-frequency behavior, but the full 2010-2023 dataset (perhaps aggregated to months) would give better understanding of inter-annual dynamics.

* It is incorrect that "The oscillating pattern displayed in the ACF plots supports that the data is non-stationary."  The usual motivation for the sample ACF assumes a stationary model.

* An unclear assertion, "By comparing the AIC values and model complexity, the most appropriate model is: SARIMA(2,0,0)×(0,0,1)". SARIMA(1,0,1)×(0,0,1) has the same complexity and better AIC, so the reasoning is unclear.

* This dataset is called "Travel-related cases" so it may be that not much local transmission occurs in US. In that case, modeling US cases by an SIR model (or any extension of it) may be hard to interpret. The pattern could be driven not by US transmission but by a sinusoidal fluctuation in imported cases.

* The model supposes that $N=3.2\times 10^6$ Americans are at risk of dengue. Where does this figure come from?

* A referee requested discussion about the homogeneous mixing assumption behind compartment models. That is an interesting topic: that assumption motivates the model and guides its interpretation, but ultimately the statistical skill of the model is judged by its ability to fit the data regardless of fact that humans do not mix anything like homogenenously.






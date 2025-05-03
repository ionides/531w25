---
title: "Review comments on Final Project 5"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

*  The inclusion of mosquito dynamics is original in the context of 531. The resulting POMP model is clearly explained.

* In the conclusion, these two likelihoods are improperly compared: "as seen in the difference in likelihoods between the SARIMA model (-96) and the POMP models (-328), there is a significant scope for improvement in the mechanistic models." The SARIMA is fitted to the log of the data, and not adjusted for the transformation.

### Minor points (strengths or weaknesses or errors or potential improvements)

* The STL decomposition is informative here, unlike various other epidemic time sereis.
Here, it is not necessary to take logarithms to linearize the dynamics, because this low-prevalence situation (in US, malaria does not spread effectively) is already close to linear, additive dynamics.

* One could consider detrending rather than concluding "differencing the series will be advisable and possibly needed."

* Using a periodogram to infer seasonality is overkill. If the periodogram does not show anything surprising (often the case) you don't have to claim that you use it to infer annual seasonality.

* SARIMA model AIC comparison does not take into account the loss of a datapoint when differencing; AIC is not perfectly comparable.

* The SARIMA residual diagnostics show a good fit. The report does not explain clearly that this is fitted to the log of the data.

* It would be nice to have the Jacobian correction so that the SARIMA log-likelihood for log-data can be properly compared to the POMP log-likelihood for the raw data. 

* Two log-likelihoods claimed to both equal -332.02 are neither equal to -332.01 (they are -331.077 and -331.386). A strange typo, but fortunately these likelihoods are indeed close.

* Rainfall data could be very helpful as a covariate given the known ecology of the mosquito vector. Including that is beyond the expected scope for a good 531 project.



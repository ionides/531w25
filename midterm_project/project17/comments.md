---
title: "Review comments on Project 17"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. An ambitious neural net approach to forecasting stocks using a convolutional neural net with a bidirectional long short term structure combined with a multi-headed attention mechanism, trained using transfer learning. This could be a weakness, since the use of such a complex model is not fully justified, but overall it is a strength since the current interest in such models in various machine learning applications is widely known.

1. The small but highly significant effect of the volatility index (VIX) on predicting Tesla is notable. If VIX lagged by one day also has that effect, it would be actionable for trading.

1. Reproducibility is provided by a Jupyter notebook for the deep learning together with Rmd for the rest of the data analysis. The complicated CNN-BiLSTM-Attention model is interesting but hard to validate, so this reproducibility is critical.

1. The project's contribution is explained in the context of previous midterm projects.

1. The presentation is strong, though section numbers, and figure/table numbers and captions would help the reader.

### Specific comments

1. The pandemic was March 2020 to 2023, which contradicts the stated motivation of using data up to July 2022 to avoid the pandemic.

1. The residuals have considerably longer tails than normal - this is better seen from a QQ plot.

1. The ARMA(0,0) is prefered by AIC and parsimony. 

1. There are some inconsistencies within the AIC table ({(1,2), (1,3)}, {(3,3), (3,4)}, {(3,2), (4,2)}), which are not fully addressed in the report. Those inconsistencies can be discussed with respect to optimization and model selection.

1. Regarding the model diagnostics, the Ljung-Box test suggests that ARMA(1,1) residuals are uncorrelated, while the ACF plot of residuals suggests a possible sinusoidal pattern, implying missed periodicity.
That may well be the same periodicity identified earlier in the original data - which would imply that ARMA(1,1) is not explaining that feature.
This is a good example where looking at the ACF is more informative than presenting a Ljung-Box statistic.

1. For the CNN analysis, the Test Set Prediction plot explanation seems to suggest that the model was fitted up to 2020-02 and then forecast. However, the plot seems too close to the data to fit that description.

1. The motivation of applying the CNN-BiLSTM-Attention model is stated as that the traditional ARMA-like models cannot outperform white noise for log returns.
The author can further support this argument by directly comparing out-of-sample prediction accuracy (e.g., RMSE) between the ARMA and deep learning models.


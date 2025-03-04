---
title: "Review comments on Project 8"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths


1. An in-depth investigation of ARIMA likelihood maximization issues, discovering things beyond what was covered in class.

1. A careful discussion of differencing, and its role in helping to identify causal relationships while avoiding spurious relationships between trends. However, suitable detrending may be able to do those things too, perhaps better. 

1. The Comparison with Past Projects section provides context and identifies a novel contribution.

1. Extensive references and footnotes demonstrate strong scholarship

### Specific comments

1. The team provide summaries of marginal distributions, e.g., "Average aligned with the median," which have little value when the data distribution varies substantially with time. 

1. The residual plot (and quantile plot) show one massive outlier and one slightly less dramatic, but nevertheless large, outlier. It would be good to examine these data points individually for possible data collection issues. How sure are we that they are correctly recorded? Do they match known extreme weather events?

1. Could the problem with identifying a precipitation/level effect be due to a lag relationship? Though, the lag effect should be via run-off into the lake, so perhaps this is not plausible. Alternatively, lake level could depend on integrated rainfall over several months, which could be hard to detect in this analysis.

1. Using covariates with differenced ARIMA (d>0) is delicate. What model do you think you are fitting? Here, we want the covariances to be fitted to the differenced data because the covariates are hypothesized to affect the change of water level not directly the level itself.

1. The authors state: “Evaporation is a major contributor to water loss in Lake Malawi, often exceeding the Shire River outflow” which begs the question if lake outflow should be another water component to take into consideration since runoff only is for entering the lake.

1. For the log transformation, different specifications are proposed but it is unclear how the team picked the "best".

1. The raw MAE suggests that evaporation was the easiest to predict. However, the weighted MAE changes the story completely “forecasting errors for evaporation pose a more significant challenge to predicting water levels than those for precipitation”. Since this may seem paradoxical, it would be worth the authors defining what weighting the MAE for each variable by its impact on water level means. Perhaps giving the formulas of how they computed the weighted MAE without looking in the source code.

1. The start of the Regression section looks to explain trending data linearly in terms of non-trending covariates. This seems doomed to failure and could be avoided. There is good rationale for differencing the level data, as is done subsequently.


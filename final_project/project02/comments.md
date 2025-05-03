---
title: "Review comments on Final Project 2"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* A great introduction. Helpful for a reader with general time series interests but no specific prior experience with sports analytics. The conclusions are carefully worded and are supported by the results.

* Poisson noise (no overdispersion) in the main observation model. Subsequently, there is a nice analysis of how negative binomial noise is investigated but is found to be less necessary for a model having opponent covariates and momentum. Alternatively, the negative binomial model could imply that momentum is not necessary. Apparently, one team for one season is not enough to distinguish this.  The authors recognize this. They appropriately investigate the question of whether momentum matters with an open mind, looking for the evidence both ways coming from the models and data.

* The analysis is missing a benchmark, but does compare to alternative versions of the model.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Section/equation/figure numbers would be helpful.

* The form of the model is not given any justification. Maybe this sort of social science does not have strong reasons to prefer one model over another; it could be just an empirical question. But the issue should be addressed.

* a typo in the normal transition density model: $\phi x_{n-1}$ should be $x_n - \phi x_{n-1}$.

* Future work could extend this to more teams. That extended analysis is beyond the reasonable scope of a 531 final project.

* Note that the Tigers offensive skill ($X_n$) autoregresses toward 0 but we add a team-specific long-run average skill, $\mu$.









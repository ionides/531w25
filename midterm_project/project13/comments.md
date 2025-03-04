---
title: "Review comments on Project 13"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. The spectral power around 2.3 days is surprising; the team manage to remove it by band pass filtering, but perhaps they are removing something interesting that could instead be investigated. 

1. The team studied and learned from past projects as well as using a range of methods covered in class. 

1. The code is reproducible. As a small detail, the random number seed could be set using `set.seed()` to make it fully reproducible.

### Specific comments

1. The ACF for the returns has surprisingly many nominally significant correlations. Is that a consequence of large outliers making the central limit theorem irrelevant?

1. The seasonality in the STL plot looks strange; what is the period of the "seasona"? Not one year.

1. The spectral peak at 2.3 days is surprising, but matches the ACF. Could it be a COVID artifact? Is it driven just by the 2020 crash, or does it arise also elseqhere?

1. Why is ARMA(7,5) "much simpler" than ARMA(6,9)? Both are very big models. ARMA(2,2) has competitive AIC and is much simpler.

1. The likelihood ratio test is carried out between ARMA(6,9) and ARMA(9,0) models, but these models are not nested and this makes the LRT inapplicable.

1. It looks from the Model Diagnostics section that ARMA(2,2) was considered at some point, but didn't make the final version. 

1. Prophet is assessed as "having learned quite well" but this seems to be based on one forecast. A sample size of one is not enough for much confidence. 

1. Having put much work into developing an ARMA model, it would make sense to obtain the ARMA forecast for comparison with Prophet.

1. The use of ChatGPT to code a Butterworth bandpass filter is a legitimate technique, but the method is not fully explained. It would have been safer to use a Loess filter familiar to readers from the class notes.

1. It's interesting to see how Prophet performs, but ultimately it is just a regression model and, if the efficient market hypothesis is close to holding, Prophet cannot be expected to predict much better than a simple model of constant expected growth rate plus unpredictable variation. 

1. If this index is not tradeable, the marked does not force it toward satisfying the efficient market hypothesis. Could that explain the observed correlation?

1. Much longer than Gaussian tails are noted, but what can be done about it? Various previous projects analyzing financial data use specific financial models not covered (yet) in class. Sometimes those projects do not explain the methods in sufficient detail, but it would be good to at least acknowledge these approaches.

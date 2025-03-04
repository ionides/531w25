---
title: "Review comments on Project 15"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. The project covers a good range of methods from class and experiments with an additional bootstrap approach. The presentation is scholarly; most of the time there is a good balance between text, figures, code and results (in a few places, too much R output is presented).

1. The decision to log-transform is appropriate.

1. The goal is to inform emergency response efficiency and road safety measures and policy decisions to reduce fatalities, and developing a reasonable time series model does seem to support those things but perhaps the project could have made this connection more concrete (or at least conjectured about this).

1. The report is reproducible from the provided code.

### Specific comments

1. Section numbers, figure numbers and captions would help the reader.

1. Frequency is easier to read in unit of cycles per year. 

1. AIC boostrap standard errors is an interesting idea. However, we are most interested in the difference between AIC values, so it is not clear how much the bootstrap errors help with those interpretations. We could do a bootstrap as an alternative to a likelihood ratio test, for example.

1. The AIC table has some mathematical inconsistencies (nested models with impossibly higher likelihoods) which should be noted.

1. The Box-Ljung test has a p-value of 0.6688 but a comment (that is not clarified in the text or code) that "Using this test, we obtain a p-value less than 0.05 in some runs, which suggests that significant autocorrelation remains." This is unclear.

1. The seasonality is very evident here, so it seems more time should be spent on SARIMA than ARIMA.

1. The SARMA(1,1)x(1,1) looks competitive and simple, and much better than ARMA(3,1). Why did auto.arima not find that? Perhaps it was not told about the period?

1. `auto.arima()` is a reasonable algorithm, but why are its choices "most appropriate"? Its goal is to do a reasonable job when analyzing too many time series to permit individual attention by a trained time series analyst. It does not claim to be better than carefully reasoned model selection.

1. No reference is made to previous 531 midterm projects. This makes it harder for the reader to put this project into the context of previous projects. A stated requirement for this assignment was to learn from the successes and failures of previous projects.

---
title: "Review comments on Project 5"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. An original question, with thoughtfully produced time series involving some appropriate natural languate processing. The effort to try something different from most previous projects is appreciated.

1. Thoughtful model selection; this ends up at the same model as selected by `auto.arima`

1. The cycling (and, more often, the lack of it) informs the idea that names periodically go in and out of fashion.

1. Demonstrating good scholarship: well-referenced and reproducible.

1. The methods used for this project were placed in the context of previous 531 projects.

### Specific comments

1. Female name length seems to be increasing more than male - but also decling more since the peak. The assessment that both male and female trends look similar does not appear justified.

1. "Since the p-value is below 0.05 for the female trend model" : but the errors are highly autocorrelated and therefore OLS p-values are not trustworthy.

1. Too much R output is included; we do not need to see the entire `lm` summary. The use of `tslm` deserves attention: the reader will be more familiar with `lm`, and, either way, it should be explained that this is a least squares fit rather than asking the reader to decode it.

1. Warnings and other distracting R output should be avoided or suppressed.

1. Numbering of sections and figures, and captions for figures, would help the reader deal with the large number of figures. The nature of this project involved repeating various analysis three times, but please respect the reader's attention span by focusing on results needed for the main argument of the investigation.


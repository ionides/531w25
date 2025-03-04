---
title: "Review comments on Project 7"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. Referees found that the document is reproducible.

1. The project covers various topics discussed in class. Further, the team tried some methods not covered in class, though perhaps additional attention to class material would have been helpful before moving on to try other things. 

### Specific comments

1. The contextualization with past midterm projects is vague. It does not acknowledge previous analysis of gold (e.g., https://ionides.github.io/531w22/midterm_project/project03/blinded.html and https://ionides.github.io/531w22/midterm_project/project09/blinded.html)

1. The linked Kaggle dataset is 2014-01-01 to 2024-10-31, so the introductory statement, "This project uses historical daily gold price data from 2015 to 2021" is unclear. Later data shown are after 2021. This confusion, and the reference to an outdated link (Chodavadiya, N. (2021). Daily Gold Price (2015-2021) Time Series Dataset. Retrieved from https://www.kaggle.com/datasets/nisargchodavadiya/daily-gold-price-20152021-time-series) which updates to the recent data seems strange. Unfortunately, such errors make it look like this old reference was retrieved from some undisclosed source.

1. The report should not be cluttered with irrelevant output, such as pages of minor notes about package installations. Beyond that, too much code and output is shown with relatively litle explanation and discussion.

1. Marginal plots for time series with trends are fairly uninformative. Better to show a time plot (which is only shown later, with the STL). The discussion of the marginal plots is unclear, and it seems the points would be easier to see on a time plot.

1. The STL decomposition is not particuarly insightful in this case - except perhaps that there is a hint of some seasonality, but 2yr of data is not enough to confirm this. The STL does not prove that there are regular seasonal patterns: by mathematical construction, it necessarily estimates them, but the estimate is small and perhaps not statistically significant.

1. The timeplot does not agree with the comment, "In early 2020 and March 2024, gold prices fluctuated significantly."

1. The ARMA root plot has an accidental `Mod` in its definition, so all plotted inverse roots show up as being real.

1. For the residual plot, "a few outliers (early 2020 and mid-2024)" is unclear, since dates are not plotted, but the data analyzed seem to start in 2022. Having identified outliers, it would be interesting to dig into the economic history and conjecture what might have caused them. Google on "why did gold price peak in march 2022" suggests it was the war in Ukraine.

1. References are not cited in the text, just listed at the end. This makes it hard to see what is being credited.

1. What is Jarque-Bera Test? This kept showing up in the GARCH modelling outputs. Either omit it (it does not appear to contribute much here) or explain it and why it is worthwhile.

1. The project has no spectral analysis. That might be worth doing to confirm the presence (or otherwise) of significant seasonality.

1. While the authors claim in their conclusion that their forecasts align well with the recent movements, we are not actually shown any evidence of this. The test set is mentioned in the preprocessing section and never acknowledged again. We are shown plots of the forecasted values but we have no way to compare these to the test set.

1. The writing also includes odd bolding of words in specific sections, which makes readers suspect that generative AI may have been used for writing. chatGPT is cited, but we are given no information as to how it was used: a reference should be cited in the text where relevant, or, if use is too extensive for that, the topic should be discussed.

1. The definitions of key covariates such as Open and Volume are missing. The report should be written to be accessible to statistics masters students who are not necessarily familiar with details of financial markets.

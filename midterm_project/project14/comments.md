---
title: "Review comments on Project 14"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. A range of appropriate methods were investigated, explained and interpreted.

1. The work was put in the context of previous midterm projects. 

1. The code is reproducible and generally well written.

### Specific comments

1. The project states, "It appears that the price before 2020 remains relatively low and stable". This is because the value is not plotted on a log scale. Using a log scale would make the trajectory before 2020 much clearer.

1. ARMA(0,0) looks reasonable based on the AIC table.

1. The interpretation of the ARMA(1,0) QQ plot as being "close to normality" is wrong - these are long-tailed. Of course, whether this discrepancy is practically significant will depend on the purpose.

1. The likelihood ratio test for ARMA(1,0) vs ARMA(0,1) is invalid because the models are not nested. Indeed, the difference of degrees of freedom is zero. The team used `lmtest::lrtest` without explaining what it does in this situation.

1. The trend would be better modeled on a log scale. Indeed, the original time plot would also be more informative on a log scale since it would let us see the fluctations when Tesla stock was much less valuable.

1. Sometimes, too many results were shown. It's better to spend more time focusing on key numbers and figures. For example, showing the sample ACF of the price data is not insightful and best avoided. 

1. Every figure should have an appropriate title and labels. Additionally every figure and R output should have a corresponding discussion. 

1. The report would benefit having a clear explanation of how ARMA and GARCH interact with one another since we haven’t studied GARCH models. The authors provide the R output of the ARMA-GARCH model, but fail to discuss anything about it. There is a lot of information displayed in the R output and a discussion on the key points would greatly aid the reader in understanding.

1. The conclusion, "Our Fourier analysis revealed dominant frequencies in Tesla’s returns, while Wavelet analysis captured non-stationary volatility fluctuations, particularly around earnings releases. These insights provide a more comprehensive understanding of stock price behavior, offering valuable implications for short-term traders and risk management strategies." seems unfounded. No wavelet analysis was presented, and no dominant frequencies were found.

1. The project could have been strengthened by the consideration of covariate time series and/or model breakpoints to help understand why Tesla stock sometimes seemed to change behavior. 


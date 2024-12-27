---
title: "Selected papers for STATS 631"
author: "Instructor: Edward L. Ionides"
output:
  html_document:
    toc: no
---

## Preliminary schedule

1. Week starting Jan 13: [__akaike74__](https://doi.org/10.1109/TAC.1974.1100705)
<br>
AIC is recommended by influential recent time series papers, including those later on our reading list (hyndman08,taylor18).Hirotugu Akaike developed his ideas in a sequence of papers, but this is the first one which focuses on the current standard definition of AIC. Akaike's foundational papers are 50 years old, and there has been much work on model selection since then. Why have  Akaike's ideas been so persistent?  

1. Week starting Jan 20: [__box76__](https://doi.org/10.1080/01621459.1976.10480949)
<br>
George Box's work popularized the ARIMA framework for time series. Among many other notable contributions, he is responsible what is perhaps the most widely quoted advice for applied statistics, "All models are wrong, but some models are useful.'' This influential discussion of the relationship between science and statistics, and the role of models in this relationship, is informed by Box's extensive work in time series analysis. Look for places where dependence, including temporal dependence, play a role.

1. Week starting Jan 27: [__hyndman08__](https://doi.org/10.18637/jss.v027.i03)
<br>
Rob Hyndman's many contributions to time series analysis include the development of `auto.arima`, a widely used approach for choosing ARIMA models. Here, we dig into the construction of this procedure and its motivation.

1. Week starting Feb 3: [__taylor18__](https://doi.org/10.1080/00031305.2017.1380080)
<br>
This paper introduces a widely used modern forecasting tool, [Facebook Prophet](https://cran.r-project.org/web/packages/prophet/index.html): Facebook Prophet (https://cran.r-project.org/web/packages/prophet/index.html). Facebook Prophet is not based on ARIMA modeling, and the difference between these approaches is worth consideration.

1. Week starting Feb 10: [__lim21__](https://doi.org/10.1098/rsta.2020.0209)
<br>
Deep learning has been influential throughout statistics, and time series analysis is no exception. This review discusses the deep learning for time series, situated before the widespread popularization of transformers.

1. Week starting Feb 17: [__gruver24__](https://proceedings.neurips.cc/paper_files/paper/2023/file/3eb7ca52e8207697361b2c0fb3926511-Paper-Conference.pdf)
<br>
When is GenAI useful for time series analysis? 

1. Week starting Feb 24: [__bjornstad01__](https://doi.org/10.1126/science.1062226)
<br>
There are surprisingly many important ideas about time series analysis for nonlinear stochastic dynamic systems discussed in this compact paper. The issues it raises have prompted much work over the past two decades, and some issues remain unresolved.

Spring Break

8. Week starting Mar 10: [__doucet09__](http://www.warwick.ac.uk/fac/sci/statistics/staff/academic-research/johansen/publications/dj11.pdf)
<br>
Particle filtering facilitates time series analysis for many nonlinear systems. We study a review of this technique by two leading experts.  

1. Week starting Mar 17: [__kristensen16__](https://doi.org/10.18637/jss.v070.i05)
<br>
Perhaps the main alternative to likelihood-based inference for POMP models is the locally Gaussian approximation used in the integrated nested Laplace approximation method. A popular implemention is Template Model Builder. 

1. Week starting Mar 24: [__shuert22__](https://doi.org/10.1073/pnas.2121092119)
<br>
A recent analysis of ecological response to global climate change.

1. Week starting Mar 31: [__wheeler24__](https://doi.org/10.1371/journal.pcbi.1012032)
<br>
A paper dealing with various practical issues in data analysis via mechanistic models, including residual analysis and benchmarking to help identify model misspecification.

1. Week starting Apr 7: [__subramanian21__](https://doi.org/10.1073/pnas.2019716118)
<br>
Many papers were written fitting mechanistic models to learn about COVID-19 transmission and to forecast its trajectory. This paper shows how it is critical to understand both the reporting process and the disease dynamics.

1. Week starting Apr 14: [__lau21__](https://doi.org/10.1371/journal.pcbi.1010251)
<br>
Machine learning and mechanistic modeling are sometimes seen as alternative approaches whereas they should work together to complement each other. This paper investigates the possibilities in a case study.

## References for the STATS 631 reading group

[__akaike74__](https://doi.org/10.1109/TAC.1974.1100705).
Akaike, H. (1974). A new look at the statistical model identification. _IEEE Transactions on Automatic Control_, 19(6), 716-723. 

[__bjornstad01__](https://doi.org/10.1126/science.1062226).
Bjørnstad, O. N., & Grenfell, B. T. (2001). Noisy clockwork: time series analysis of population fluctuations in animals. Science, 293(5530), 638-643. 

[__box76__](https://doi.org/10.1080/01621459.1976.10480949).
Box, George E. P. (1976). Science and statistics. _Journal of the American Statistical Association_, 71 (356): 791–799.

[__doucet09__](http://www.warwick.ac.uk/fac/sci/statistics/staff/academic-research/johansen/publications/dj11.pdf).
Doucet, A., & Johansen, A. M. (2009). A tutorial on particle filtering and smoothing: Fifteen years later. _Handbook of Nonlinear Filtering_, 12(656-704), 3. 

[__gruver24__](https://proceedings.neurips.cc/paper_files/paper/2023/file/3eb7ca52e8207697361b2c0fb3926511-Paper-Conference.pdf).
Gruver, N., Finzi, M., Qiu, S., & Wilson, A. G. (2024). Large language models are zero-shot time series forecasters. _Advances in Neural Information Processing Systems_, 36.

[__hyndman08__](https://doi.org/10.18637/jss.v027.i03).
Hyndman, R. J. & Khandakar, Y. (2008) Automatic time series forecasting: The forecast package for R. _Journal of Statistical Software_, 26(3).  

[__kristensen16__](https://doi.org/10.18637/jss.v070.i05).
 Kristensen, K., Nielsen, A., Berg, C. W., Skaug, H., & Bell, B. M. (2016). TMB: Automatic Differentiation and Laplace Approximation. _Journal of Statistical Software_, 70(5), 1–21. 

[__lau21__](https://doi.org/10.1371/journal.pcbi.1010251).
Lau, M. S., Becker, A., Madden, W., Waller, L. A., Metcalf, C. J. E., & Grenfell, B. T. (2022). Comparing and linking machine learning and semi-mechanistic models for the predictability of endemic measles dynamics. _PLOS Computational Biology_, 18(9), e1010251. 

[__lim21__](https://doi.org/10.1098/rsta.2020.0209).
Lim, B., & Zohren, S. (2021). Time-series forecasting with deep learning: a survey. _Philosophical Transactions of the Royal Society A_, 379(2194), 20200209. 

[__shuert22__](https://doi.org/10.1073/pnas.2121092119).
Shuert, C. R., Marcoux, M., Hussey, N. E., Heide-Jørgensen, M. P., Dietz, R., & Auger-Méthé, M. (2022). Decadal migration phenology of a long-lived Arctic icon keeps pace with climate change. Proceedings of the National Academy of Sciences, 119(45), e2121092119.

[__subramanian21__](https://doi.org/10.1073/pnas.2019716118).
Subramanian, R., He, Q., & Pascual, M. (2021). Quantifying asymptomatic infection and transmission of COVID-19 in New York City using observed cases, serology, and testing capacity. _Proceedings of the National Academy of Sciences_, 118(9), e2019716118.

[__taylor18__](https://doi.org/10.1080/00031305.2017.1380080).
Taylor, S. J., & Letham, B. (2018). Forecasting at scale. _The American Statistician_, 72(1), 37-45. 

[__wheeler24__](https://doi.org/10.1371/journal.pcbi.1012032).
Wheeler, J., Rosengart, A., Jiang, Z., Tan, K., Treutle, N., & Ionides, E. L. (2024). Informing policy via dynamic models: Cholera in Haiti. _PLOS Computational Biology_, 20(4), e1012032. 


## Generic questions

1. What is the weakest part of the paper? Is there a limitation that may make the paper less useful in practice, or even misleading. (This may be rare, or hard to find, in high-impact papers.)

2. What is the strongest part of the paper? i.e., something that the paper demonstrates which deserves to be widely known.

3. Has the paper had an impact on statistical theory and/or methodology and/or applications? Why or why not?

4. Technical questions
    (a) Why was the notation set up this way?
    (b) What steps need additional explanation to be clear to this reader?

5. Study the figures and tables. To what extent do they support the conclusions of the paper?
    
## Meeting format

* Grading is on attendance, participation in a weekly 1-hour discussion, and at least minimal preparation.

* Minimal preparation means spending one hour reading the paper and thinking about its contribution. This is a useful academic skill---we read many more papers superficially than we can read in detail.

* All the papers we read are worth many hours of study, and you are welcome to spend as long as you like if you want to get deeper understanding.





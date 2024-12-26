---
title: "Selected papers for STATS 631"
author: "Instructor: Edward L. Ionides"
output:
  html_document:
    toc: no
---

## Preliminary schedule

1. Week starting Jan 13. A paper by Akaike. AIC is recommended by influential recent time series papers, including those later on our reading list (hyndman08,taylor18). Akaike's foundational papers are 50 years old, and there has been much work on model selection since then. Why have Hirotugu Akaike's ideas been so persistent?

1. Week starting Jan 20. box76. George Box pioneered the ARIMA framework for time seris. Among many other notable contributions, he is responsible what is perhaps the most widely quoted advice for applied statistics, "All models are wrong, but some models are useful.'' Box's discussion of the relationship between science and statistics, and the role of models in this relationship, is informed by his extensive work in time series analysis. 

1. Week starting Jan 27. hyndman08. Rob Hyndman's many contributions to time series analysis include the development of `auto.arima`, a widely used approach for choosing ARIMA models. Here, we dig into the construction of this procedure and its motivation.

1. Week starting Feb 3. taylor18. Facebook Prophet is a widely used forecasting tool. It is not based on ARIMA modeling, and the difference between these approaches is worth consideration.

1. Week starting Feb 10. lim21. Deep learning has been influential throughout statistics, and time series analysis is no exception. This review discusses the deep learning for time series, situated before the widespread popularization of transformers.

1. Week starting Feb 17. gruver24. When is GenAI useful for time series analysis? 

1. Week starting Feb 24. bjornstad01. There are surprisingly many important ideas about time series analysis for nonlinear stochastic dynamic systems discussed in this compact paper. The issues it raises have prompted much work over the past two decades, and some issues remain unresolved.

Spring Break

8. Week starting Mar 10. doucet09. Particle filtering facilitates time series analysis for many nonlinear systems. We study a review of this technique by two leading experts.  

1. Week starting Mar 17. 

1. Week starting Mar 24. 

1. Week starting Mar 31. wheeler24. This case study discusses and demonstrates various practical issues involved in data analysis via mechanistic models. 

1. Week starting Apr 7. subramanian21. Many papers were written fitting mechanistic models to learn about COVID-19 transmission and to forecast its trajectory. This paper shows how it is critical to understand both the reporting process and the disease dynamics.

1. Week starting Apr 14. lau21. Machine learning and mechanistic modeling are sometimes seen as alternative approaches whereas they should work together to complement each other. This paper investigates the possibilities in a case study.

## References for the STATS 631 reading group

1. A paper by Akaike on the development of AIC. Options include:
    + [Akaike, H. (1978)](https://www.jstor.org/stable/pdf/2988185.pdf). On the likelihood of a time series model. Journal of the Royal Statistical Society: Series D (The Statistician), 27(3-4), 217-235.
    + Akaike, H. (1974). A new look at the statistical model identification. IEEE transactions on automatic control, 19(6), 716-723. [doi](https://doi.org/10.1109/TAC.1974.1100705).
    + Akaike, H. (1998). Information theory and an extension of the maximum likelihood principle. In Selected papers of hirotugu akaike (pp. 199-213). New York, NY: Springer New York. [doi](https://doi.org/10.1007/978-1-4612-1694-0_15).

1. "All models are wrong, but some are useful". This is generally attributed to GEP Box, whose book on time series analysis is a landmark in the field. A paper very relevant to applied statistics in general, if not specifically focused on time series analysis:
Box, George E. P. (1976), "Science and statistics" (PDF), Journal of the American Statistical Association, 71 (356): 791–799, doi:10.1080/01621459.1976.10480949

1. Hyndman, RJ and Khandakar, Y (2008) "Automatic time series forecasting: The forecast package for R", Journal of Statistical Software, 26(3).

1. Taylor, S. J., & Letham, B. (2018). Forecasting at scale. The American Statistician, 72(1), 37-45. : Facebook Prophet (https://cran.r-project.org/web/packages/prophet/index.html)

1. Lim, B., & Zohren, S. (2021). Time-series forecasting with deep learning: a survey. Philosophical Transactions of the Royal Society A, 379(2194), 20200209. [doi](https://doi.org/10.1098/rsta.2020.0209).

1. Gruver, N., Finzi, M., Qiu, S., & Wilson, A. G. (2024). Large language models are zero-shot time series forecasters. Advances in Neural Information Processing Systems, 36.
[pdf](https://proceedings.neurips.cc/paper_files/paper/2023/file/3eb7ca52e8207697361b2c0fb3926511-Paper-Conference.pdf).

1. Zeng, A., Chen, M., Zhang, L., & Xu, Q. (2023, June). Are transformers effective for time series forecasting?. In Proceedings of the AAAI conference on artificial intelligence (Vol. 37, No. 9, pp. 11121-11128). [doi](https://doi.org/10.1609/aaai.v37i9.26317).

1. Bjørnstad, O. N., & Grenfell, B. T. (2001). Noisy clockwork: time series analysis of population fluctuations in animals. Science, 293(5530), 638-643. [doi](https://doi.org/10.1126/science.1062226).

1. Doucet, A., & Johansen, A. M. (2009). A tutorial on particle filtering and smoothing: Fifteen years later. Handbook of nonlinear filtering, 12(656-704), 3. [pdf](http://www.warwick.ac.uk/fac/sci/statistics/staff/academic-research/johansen/publications/dj11.pdf).

1. Lau, M. S., Becker, A., Madden, W., Waller, L. A., Metcalf, C. J. E., & Grenfell, B. T. (2022). Comparing and linking machine learning and semi-mechanistic models for the predictability of endemic measles dynamics. PLoS computational biology, 18(9), e1010251. [doi](https://doi.org/10.1371/journal.pcbi.1010251).

1. A paper dealing with various practical POMP issues, including residual analysis and benchmarking to help identify model misspecification. Wheeler, J., Rosengart, A., Jiang, Z., Tan, K., Treutle, N., & Ionides, E. L. (2024). Informing policy via dynamic models: Cholera in Haiti. PLOS Computational Biology, 20(4), e1012032. [doi](https://doi.org/10.1371/journal.pcbi.1012032).

1. Subramanian, R., He, Q., & Pascual, M. (2021). Quantifying asymptomatic infection and transmission of COVID-19 in New York City using observed cases, serology, and testing capacity. Proceedings of the National Academy of Sciences, 118(9), e2019716118. [doi](https://doi.org/10.1073/pnas.2019716118)

1. Kristensen, K., Nielsen, A., Berg, C. W., Skaug, H., & Bell, B. M. (2016). TMB: Automatic Differentiation and Laplace Approximation. Journal of Statistical Software, 70(5), 1–21. [doi](https://doi.org/10.18637/jss.v070.i05).

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





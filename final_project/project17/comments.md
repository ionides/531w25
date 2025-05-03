---
title: "Review comments on Final Project 17"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* The modification of the SV for t distributed returns (Sec 2.3) is a good decision. Surprisingly, the likelihood improvesonly a little, and the estimated degrees of freedom for tau is quite large. 

* The effective sample size diagnostics show occasionall crashes even with the t-distributed tails. This is somewhat surprising, but the report correctly points out that various interesting limitations of their results are outside the scope 

* The report identifies seasonality in gasoline prices, which is interesting, but then ignores this exploratory discovery by proceeding with models that don't include seasonality.

* The report honestly describes both strengths and limitations of their analysis, with reasonable assessment of good further approaches if more time was available.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Various features of commodity prices are different from stocks. There is no economic principle against commodities autoregressing toward a fair market price, or having seasonality, whereas the efficient market hypothesis suggests this is not true for stock market assets. People cannot just buy gas if they think the price is cheap; they would have to store it. GARCH and many of its generalizations cannot handle seasonality. Interesting, this might be a time for SARMA with GARCH errors.

* Section numbers, Figure numbers and captions are provided, which is helpful for the reader.

* It would be good to comment on the computational requirements of all these experiments, as usually fitting POMP models require substantial computation. Commenting on that would also give some insights to people wanting to reproduce the results. (This is true for most projects, but came up in peer review for this one.)

* This project uses monthly data; volatility models are most commonly developed and used for higher frequency data.

* The authors can be a little more careful about the language that may imply "causation". The government policies can affect the leverage effect. However, in a very complex dynamical system such as the world, such a claim requires more evidence.

* The t degree of freedom parameter, tau, is described as being in the range [0,60] but the convergence plots suggest that is not enforced. Often, tau is sufficiently large that the t should be very close to normal, which is worth discussion.






---
title: "Review comments on Final Project 1"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* Conclusions are carefully worded, showing appreciation of what was demonstrated as well as limitations and relationships to previous work.

* A comprehensive analysis. In particular, Table 5.5.1 is a nice summary of results and their interpretation.

* $k$ could be an important parameter for fitting the data, and it should be estimated not fixed.

* Section 4 investigates a basic mechanistic model and identifies limitations. Section 5 revisits mechanistic model construction by following scientific reasoning for the system under investigation, leading to a much better model (judged by likelihood and simulations).

* The issue with interpreting the estimate of gamma is thoughtfully identified and carefully explored. 

* Creative modeling by introducing a measure of antigenic distance (to quantify flu immunity) and a restarting mechanism (to address local extinction between seasons).

* Data of this kind can be more insightfully plotted on a log scale (presented in the project later). Also, the linear analysis (additive decomposition, periodogram, ARMA) are better on a log scale. The team is correct to note that comparing likelihoods on log and natural scale requires care (i.e., a Jacobian transformation, see the Measles and Polio case studies in the notes).

* A log-SARMA benchmark would be a more rigorous test of model specification than SARMA.

### Minor points (strengths or weaknesses or errors or potential improvements)

* Influenza cases is either lab-confirmed cases (which depends critically on the amount of testing) or reported influenza-like illness (ILI) which is not all influenza. Later, it seems that what is called "cases" is ILI.

* It is not clear what is learned from the additive decomposition that cannot be seen more clearly from other plots. To study seasonality of nonlinear and highly variable systems, a simple line plot of superposed seasonal trajectories can be more informative.

* Listing the raw data is usually inappropriate. Similarly, showing raw R summaries is usually less helpful than identifying and explaining key properties. In other words, showing data and summary statistics follows the same rule as other figures and tables: if you present it, discuss it and explain what you learned from this representation.

* The ARMA section might be too long. The main thing acquired from this section is a benchmark to compare against mechanistic model fits, so it is better to focus on the mechanistic models.

* Sec 5.6 is not a poor man's profile as defined in the notes, it is a slice. The plot in 5.6.1 shows terrible likelihoods for large rho, much lower than the benchmark, but this is just due to a mismatch between the state parameters and the proposed reporting rate. This is fixed in Sec 5.7. It would be better to focus more on the profile than the slice.

* The references are helpful. They do not conform to usual standards for scientific research, but focusing on links rather than full text references makes practical sense in the context of this final project.

* The report is long and would be easier to read if it were more selective about what is included. Things that are tried and superseded can be noted in the main text and presented only in an appendix.





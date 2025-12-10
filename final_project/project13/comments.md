---
title: "Review comments on Final Project 13"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---

### Major points (relevant to the strength or correctness or scope of the conclusions)

* An innovative modeling task. However, there are major issues with how the project is presented. Various things are incomplete in strange ways, e.g., " (tweaked for a typical exoplanet study—let me know if your bounds differ)", that look GenAI generated.

* Consider the following sentences: _"We employed the DEoptim algorithm, a global optimization tool based on differential evolution, to estimate the parameters of your model. This method is perfect for handling complex, non-linear, and multi-modal likelihood surfaces, which are typical in stochastic models—especially if you’re workin with Kepler light curves modeled with a Partial Observed Markov Process (POMP) combined with an OU process and boxcar transits. Why DEoptim? It’s fantastic at finding the global maximum of the likelihood without getting stuck in local optima, unlike traditional gradient -based methods that might struggle with noisy or jagged likelihood landscapes. It doesn’t need complicated derivatives, which can be tough to compute for these kinds of models, making it a robust choice for the data."_ This reads like GenAI text.

* The use of DEoptim rather than methods studied in class raises questions. If the project showed this was better, that would be great. However, we never really find out if the method was successful. There are no benchmarks, and no serious discussion of convergence diagnostics beyond an assertion that the search was effective. The approaches covered in class do these things. The project could be (and quite likely is) avoiding  mastery of material covered in class, rather than improving on it.

* "simulated trajectories follow the general pattern of the observed data" does not seem to match the figure, where the simulated trajectories oscillate rapidly, unlike the data.

* The souce code has hard-coded results, described in the text as "Note: I made up these numbers based on typical patterns—swap in your actual log-likelihood values if you have them!" In various places, this seems like the results were just made up.

* Referees reported that at least some parts of the code (that were not too time-intensive) ran reproducibly and looked well written.

* It would be good to have statistical benchmark models to help assess the quality of fit from the likelihood of the mechanistic model. ARMA might not be good for these data, but a suitable regression model could be appropriate.

* The residual plot and residual histogram is repeatedly mentioned and yet inappropriately interpreted, due to residuals’ very clear seasonal patterns with periodicity approximately 400. The ACF plot is even much worse, with very large ACF values for all of the first 50 lags, which is totally inconsistent with the author’s interpretations below the ACF plot, and further indicates severe residual autocorrelations issue and the severe violation of residual assumption of the
current model.

### Minor points (strengths or weaknesses or errors or potential improvements)

* There are many repetitions of symbols in the equations which make the report harder to read.

* Only Figure 1 is numbered, but elsewhere there are reference to Fig. 2, Fig.3, etc, which are not numbered.

* "converged to a best log-likelihood of -151017.163, demonstrating effective optimization over 50 iterations." What is the evidence that the algorithm converged?

* Technical terms like BKJD (Barycentric Kepler Julian Date) need clear explanations for readers without specialized astronomical
knowledge to understand their significance and practical relevance.

* The redundant presentation of the transit model equation (appearing multiple times with slight variations) creates unnecessary confusion.

* Multiple nonsensical uses of "your" make it look like the writing was produced to a considerable extent by GenAI.

* The reference in the report:
    - Rappaport, S., Levine, A., Chiang, E., El Mellah, I., Jenkins, J. M., Kaltenegger, L., … & Villasenor, J. (2012). “Light-curve Analysis of KIC 12557548b: An Extrasolar Planet with a Comet-like Tail.” The Astrophysical Journal, 752(1), 1.

    does not exist. Two somewhat close matches are:

    - Rappaport, S., Levine, A., Chiang, E., El Mellah, I., Jenkins, J., Kalomeni, B., Kite, E.S., Kotson, M., Nelson, L., Rousseau-Nepton, L. and Tran, K., 2012. Possible disintegrating short-period super-Mercury orbiting KIC 12557548. The Astrophysical Journal, 752(1), p.1.

    - Budaj, J. (2013). Light-curve analysis of KIC 12557548b: an extrasolar planet with a comet-like tail. Astronomy & Astrophysics, 557, A72.

    This strange error looks like a GenAI hallucination. This is minor from the point of view of the credibility of the conclusions, but not small from the point of view of scholarship.





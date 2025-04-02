---
title: "Wheeler et al. (2024)."
date: "Apr 3, 2025"
output:
  ioslides_presentation:
    smaller: no
    widescreen: true
    transition: "faster" 
---

## Impact

* Cited 10 times. 

* Not much impact, yet.

* This is a didactic article. Will the appropriate people read and learn from it?


## How far could one get with TMB?

* The SpatPOMP model analyzed here is state-of-the-art methodologically, as a particle filter likelihood maximization task.

* If TMB can give a satisfactory approximation we'd like to know!

* If not, can one find a spectrum of models stretching continuously from situations where TMB succeeds to situations where it is unacceptable?

## Deterministic vs stochastic

* Many papers postulate ODE models and fit by least squares. Why?

## Reproducibility and extendability

* Basic reproducibility (of statistical results) is the provision of code and data with a script that can be run to generate the tables and figures in a published paper.

* This is good. But when code is complex, this is not enough to enable typical researchers to experiment with the methods and choice of analysis.

* Extendable code must learn from software engineering practices.

* This also helps to prevent errors in the published paper.

## Use and abuse of methods

* Plug-and-play methods enable researchers to fit mechanistic POMP models.

* But nonlinear stochastic dynamic models can have complex behaviors - fitting a model is only a step toward a careful, correct and insightful data analysis.

* There are many pitfalls. How should we avoid them and help others avoid them?

* Complex statistical methods seem to suppress thought: people who work long and hard to find numbers that may support their conclusion are empirically predisposed to belive those numbers uncritically. Is this [cognitive bias](https://en.wikipedia.org/wiki/List_of_cognitive_biases)

    + Confirmation bias
    + Quantification bias
    + Sunk cost fallacy
    + Effort justification






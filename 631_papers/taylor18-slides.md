---
title: "Taylor & Letham, 2018"
date: "Feb 6, 2025"
output:
  ioslides_presentation:
    smaller: no
    widescreen: true
    transition: "faster" 
---

## Impact

This influential paper (cited over 3000 times, but that's an underestimate of the impact of prophet) avoids usual models of time series dependence in favor of penalized regression, in something like a structured hierarchical autoregressive model.

## Goal

We have observed two main themes in the practice of creating business forecasts. First, completely automatic forecasting techniques can be hard to tune and are often too inflexible to incorporate useful assumptions or heuristics. Second, the analysts responsible for data science tasks throughout an organization typically have deep domain expertise about the specific products or services that they support, but often do not have training in time series forecasting. Analysts who can produce high-quality forecasts are thus quite rare because forecasting is a specialized skill requiring substantial experience.

## The model

* Eq. (1) ignores temporal dependence (except as explained by trend & seasonality)

* We are, in effect, framing the forecasting problem as a curve-fitting exercise, which is inherently different from time series models that explicitly account for the temporal dependence structure in the data. While we give up some important inferential advantages of using a generative model such as an ARIMA, this formulation provides a number of practical advantages:

* Focuses on daily data which is a weakness for ARMA

## Fitting

When prophet uses stan to do L-BFGS, is it just using autodiff for optimizing the joint density (equivalent to penalized regression)?

## Model checking

* Advocates for baseline forecasts.

* Simulated historical forecasts: select a random collection of past points, but not all of them because there's no point

## Software

`library(prophet)`

https://cran.r-project.org/web/packages/prophet/vignettes/quick_start.html




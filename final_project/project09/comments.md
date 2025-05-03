---
title: "Review comments on Final Project 9"
author: "DATASCI/STATS 531, Winter 2025"
output:
  html_document:
    toc: no
---


### Major points (relevant to the strength or correctness or scope of the conclusions)

* A well-motivated project. Elo and logistic regression both provide reasonable benchmarks for predictive performance. It may be surprising that adding some well-chosen latent variables can make a substantial improvement on these methods.

* dmeas and rmeas are not quite consistent. dmeas does not subtract home advantage (i.e., give it to the opponents) when playing away.

* It would be nice to present likelihoods as well as predictive scores. Likelihood provides tools such as likelihood ratio test and AIC to seem how the improvement in prediction (on a training set)

* This project is relatively light on diagnostic investigations. How would one assess outliers, over-dispersion, or other possibilities for improved model specification? The baseline models already successfully demonstrate no major model misspecification.

* The report does not place the project securely into the context of other 531 projects (or a broader literature, but that is beyond expectatations for a final project). The topic is original, but the report should say this and the team should say what they learned from previous projects, as requested in the assignment description.

### Minor points (strengths or weaknesses or errors or potential improvements)

* One referee commented that classic Elo already adds about 100 points for home court. This could be useful information if the project is developed further.

* The code could readily be run on different teams, which would be interesting without much extra work. However, in practice, each new dataset often needs individualized attention to its particular features.

* BPM (Box Plus-Minus) should be defined at first use. This is good practice for all acronyms even if you suspect the reader may be familiar with them.






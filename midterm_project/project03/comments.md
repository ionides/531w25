---
title: "Review comments on Project 3"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. A reproducible and well-structured project demonstrating a range of methods covered in the course.

1. It is a good idea to try a t-distributed ARIMA analysis. However, the code to do this seems to be trying to fit a GARCH model with t-distributed returns, which is an entirely different model.

### Specific comments

1. The goal, "This raises the question of whether solar power generation continues to follow the expected 24-hour cycle as a strictly predictable pattern," seems rather obvious. The 24 hour day-night cycle must be relevant to solar power. Is there doube about whether this cycle will persist in the 21st century?

1. "aiming to provide deeper insights into the characteristics of solar power generation cycles." This is a vague goal. It's better to aim at a more specific question, explaining how your goal relates to previous approaches including previous class projects.

1. The questions posed on the Kaggle site for this dataset are more concrete. The team could have adopted them. They also had access to the previous Kaggle contributions that they could learn from and comment about.

1. "AIC often jumps by more than 2 points between model specifications. Such behavior suggests that the model estimation may be encountering convergence issues." Be more specific and give examples. It's only a problem when it jumps up more than 2, which is not so common in the table but does happen, e.g., {(2,0,3) (0,1,1), (3,0,3) (0,1,1)}).

1. The consideration of Box-Cox is interesting, but insufficient details are given. What is lambda estimated at? How was the SARMA likelihood corrected for this? It seems from the source code that was not done, so the AIC is not comparable to the previous ones. It is also not clear how much the standard Box-Cox approach is affected by time series dependence.

1. The conclusion is too vague: "The solar power generation process itself is a complex process, creating significant challenges in forecasting and model specification. The nature of the dataset due to its numerous confounding factors and latent variables contribute to this challenge. Additionally, ARMA model may not be sufficient to capture the intrinsic dynamics of periodicities and complexities in the dataset." What specifically is being talked about here? What are the "intrinsic dynamics of periodicities" that you have in mind?

1. The discussion of STL decomposition is vague. It finds anomalous seasonal trends in May but
does not fully explore them. More discussion about how these deviations inspire future research
can be added here.

1. The project was put briefly into the context of previous work, but the team could engage more critically with past projects, show what was used as a baseline rather than just saying that there was a past project working on a similar model.

1. Covariates might have a lag effect - this could be explored.

1. A stated goal is to develop a forecasting model, but the forecast implied by the fitted model is not demonstrated.

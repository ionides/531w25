---
title: "Review comments on Project 2"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---


### Strengths

A reproducible and well-structured project demonstrating a range of methods covered in the course.

### Specific comments

1. Kaggle is a step removed from primary data sources. It can be harder to find good information on the actual source of the numbers.

1. The total number of flights for each month is recorded in the dataset, however, there is no mention of any distinction between passenger flights and cargo flights, so more research or confirmation is warranted before claiming that the numbers are all for passenger flights.

1. The questions described in the introduction are generic and imprecise; it would be better to explain a more focused goal and achievement of the project.

1. Studying the marginal distribution of points has limited value in the presence of seasonality.

1. The PACF plot looks rather hard to use usefully in the presence of seasonality. What do we learn from this plot? If nothing, maybe it should be omitted, or limited to the study of residuals.

1. The seasonality here is so evident that it would be better to focus more on SARIMA than ARIMA.

1. Residuals "centered around zero" is not evidence of good model fit, it is a mathematical necessity from fitting the model to any data.

1. Residuals look to be auto-correlated.

1. Plotting the log on the same scale as the original data doesn't show visually what is going on. The log-transoformed data just looks constant at zero.

1. "additional peaks at frequencies around 3 and 5 suggest secondary periodic components." The report should note that these are harmonics describing non-sinusoidal seasonality at 1 cycle per year

1. For the AIC table, it is worth adding an extra row and column, even if those larger models are unlikely to be selected.

1. The ARIMA(2,1) roots plot shows the roots themselves not the inverse roots, thus they are outside the unit circle as they should be for causality & invertibility.

1. The conclusion reads, "This type of analysis is incredibly important because it offers insight into how the airline industry can structure future improvements to optimize overall efficiency in regards to the volume of flights offered each month." It would be nice to know more details about how this time series analysis can have such large impact. Without details, a big claim seems empty.

1. Covariate time series, such as the macroeconomic datasets studied in class, could be used to help understand the data and perhaps also for forecasting.

1. Captions for figures (as well as figure number/ section numbers) would help readers. There are many figures, and it is hard to keep track without help.

1. Very limited reference is made to previous midterm projects, so the project is not well placed in the context of previous work. One project is credited for "formatting the unit root test graphs, particularly visualization techniques adapted for ADF tests"




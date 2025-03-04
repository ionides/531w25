---
title: "Review comments on Project 4"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Strengths

1. The introduction presents both the broad interest in the topic and more detail on the goals of the  time series analysis.

1. The explanation of ADF is reasonable: as pointed out, its null hypothesis is not a great fit for these data, so rejection of the null might be because that specific class of nonstationary models does not fit well, rather than a convincing demonstration that no nonstationary model fits well.

1. It's impressive that the breakpoint model finds the vaccine rollout dates. However, the first breakpoint may signal an increasing transmission rate, whereas the vaccine should decrease transmission. So is this just coincidence? The model used to detect the breakpoints is not explained.

1. The causal impact analysis is an interesting idea. Intervention models can also be written in an ARMA framework, and that might lead to models that are easier to write down, and their strengths and weaknesses would become understandable from material covered in class.

1. The project's similarities and differences to previous projects is clearly explained. That is the only section that discusses transforms (log or square root) which could have been tried here.

1. A comprehensive set of references (though various of the sources are not referenced directly in the text).

1. A problem studying COVID data is time-varying diagnosis rates. The team deals with that by studying data on acute hospitalized cases; very sick people may be hospitalized at a high rate throughout the pandemic.

1. The team studied past peer reviews, e.g., "The feedback has suggested considering alternative transformations, such as log or square root scaling, to stabilize variance and comparing different lag models using AIC or likelihood ratio tests." Unfortunately this did not quite prompt them into using a suitable transformation for their data.

### Specific comments

1. It would be appropriate to study these data on a log scale. This would make a substantial difference and make all the other presented analysis simpler and more informative. 

1. Plots of marginal distributions are not necessarily informative for time series, but this one could help to indicate the suitability of a log transform.

1. The decomposition into trend/seasonal/random is not successful for this time series. Lots of pattern shows up as "random"

1. A thorough analysis of SARMA variants. The final selected pandemic model is rather large, and likely has numerical issues related to roots on the unit circle and/or close to cancelation.

1. Could the outliers post-pandemic be related to reporting or testing issues?

1. The pandemic residuals show periods of higher and lower variation. This would probably be fixed by a log transform.

1. Extremely long tails are noted in the QQ-plot, but dismissed with "the severity of the non-normality is not substantial enough to significantly impact the overall model performance". This is not supported by numerical evidence. Indeed, thinking more about this diagnostic plot could have guided the team toward realizing the utility of a log transform.

1. More inline citations could help the reader connect the sources to the text.

1. Avoid absolute path names for file references. Relative names are more reproducible.

1. Tables 1.2 through 1.7 are not well labeled, making it hard for the reader to understand what time interval each corresponds to.


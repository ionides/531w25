---
title: "Review comments on Project 16"
author: "DATASCI/STATS 531/631, Winter 2025"
output:
  html_document:
    toc: no
---

### Overall assessment

1. This project does not meet the expectations for a 531 midterm project (https://ionides.github.io/531w25/midterm_project/midterm_project_info.html) in various ways.

1. While it might be possible to write a project that analyzes synthetic data, a simulation that we are told nothing about, and for which the team also seems unaware of its construction, is a poor starting point. 

### Specific comments

1. The introduction contains undefined promises ("a controlled yet insightful manner"). There are no references cited, and the source of the synthetic data is not explained. Some of the reasoning barely makes sense ("Nevertheless, the controlled setting of synthetic data enables a focused exploration of trade dynamics, free from external variables that might obscure underlying patters"). How can one learn about trade dynamics from simulations - presumably one can only learn about a particular simulator.

1. "The average trade duration is 167.44 minutes, offering insight into the trading strategies’ effectiveness in this simulated market." How can average trade duration (whatever that is) offer insight into a  trading strategies’ effectiveness? This is not explained.

1. VAR is not explained, and its role in the progression of the analysis is unclear.

1. The clustering looks nonsensical. It just divides into 5 bands. Perhaps the simulated "price" and "quantity" are just independent draws from a uniform distribution? How does an analysis of such a distribution inform financial data analysis?

1. Presumably, the simulated trades are for many different stocks. One stock could not have variations in buy/sell prices between 0 and 1000 in a given day. So, the "daily average price" is presumably averaging trades in different stocks, which is hard to interpret as meaningful.

1. The simulated daily prices seem to have almost no trend and no heteroskedasticity of the kind seen in projects with real data. The burden is on the team to show the value of studying this particular simulation, and it is left unclear.

1. The lack of inline citations makes it hard to see whether or how the references connect to the text and the methods used. his omission weakens the credibility of the report and raises concerns about its academic integrity. Explicitly referencing relevant literature, lecture notes, or external sources would enhance clarity, demonstrate engagement with existing research, and ensure that conclusions are well-supported,

1. The project is not placed in the context of previous DATASCI/STAT 531 projects, as requested in the assignment information.

1. The conclusion, "These findings underscore the dataset’s utility for controlled strategy testing," is unsupported. Methods have been tried, and numbers generated, but how has the simulation been used to check that the methods give the right answer? The usual reasoning is that, for a simulation, you know the true data generating model so you know if your method successfully reconstructs it. Here, we never learn about how the simulation was constructed so we have no extra information whether the inferences are correct than we would get for real data.

1. The use of inline R code (R output in text blocks) is done wrong.

1. In many other places, the presentation falls short of expectations. Chunks of R code and output are included, with little explanation or interpretation. 


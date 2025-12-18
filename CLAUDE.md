
## Overview of the current task

old code is in R
new code is in Python
old lecture material is in main.Rnw using Rnw format
new lecture material is in qmd format

the subdirectories 01, 02 through 18 each contain a presentation.

the current project is to add a new file, py.qmd, to each presentation in order to provide a Python translation that compiles using the command
$ quarto render py.qmd --to beamer

## Python Translation Notes

  ### Template
  - Use slides-template.qmd in the root directory as the starting point for new py.qmd files
  - Also, learn from previously translated files, including 01/py.qmd
  - Update chapter number and topic in the title

  ### Citation Method
  - py.qmd files use biblatex citation method (not natbib)
  - Use \textcite{} for in-text citations (equivalent to R's \citet{})
  - Use \parencite{} for parenthetical citations (equivalent to R's \citep{})
  - Bibliography file is ../bib531.bib (relative to subdirectory)

  ### Data Files
  - CSV files in subdirectories may be tab-separated with comment lines starting with #
  - Example: ann_arbor_weather.csv requires pd.read_csv("file.csv", sep='\t', comment='#')

  ### Python Library Mappings (R → Python)
  - Data manipulation: R dataframes → pandas
  - Plotting: R plot() → matplotlib.pyplot
  - Time series models: R arima() → statsmodels.tsa.arima.model.ARIMA
  - ACF plots: R acf() → statsmodels.graphics.tsaplots.plot_acf

  ### Statsmodels Notes
  - The intercept/constant parameter is named 'const' (not 'intercept')
  - Access fitted parameters with model.params['param_name']
  - Access standard errors with model.bse['param_name']

  ### Python Environment
  - Requires Python virtual environment activated before running quarto
  - Run 'source .venv/bin/activate' before starting a Claude session
  - Required packages: pandas, numpy, matplotlib, statsmodels



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
  - Some data files are whitespace-separated (spaces or tabs)
  - For whitespace-separated files: pd.read_csv("file.txt", sep='\s+', comment='#', engine='python')
  - Example: Global_Temperature.txt in 02/ uses whitespace separation

  ### Python Library Mappings (R → Python)
  - Data manipulation: R dataframes → pandas
  - Plotting: R plot() → matplotlib.pyplot
  - Time series models: R arima() → statsmodels.tsa.arima.model.ARIMA
  - ACF plots: R acf() → statsmodels.graphics.tsaplots.plot_acf
  - Linear regression: R lm() → statsmodels.formula.api.ols() or statsmodels.regression.linear_model.OLS
  - Matrix operations: R cbind() → np.column_stack(), R %*% → @ operator or np.dot()
  - Extract coefficients: R coef() → model.params (for statsmodels) or model.params.values (for numpy array)
  - Extract residuals: R resid() → model.resid

  ### Statsmodels Notes
  - The intercept/constant parameter is named 'const' (not 'intercept')
  - Access fitted parameters with model.params['param_name']
  - Access standard errors with model.bse['param_name']
  - For R-like formula syntax, use statsmodels.formula.api.ols('y ~ x1 + x2', data=df).fit()
  - The summary() method provides output similar to R's summary(lm())
  - When using formula API, need to manually create transformed variables (e.g., Year_sq = Year**2)
  - For formula API, variable names with special chars need quotes or preprocessing

  ### Python Environment
  - Requires Python virtual environment activated before running quarto
  - Run 'source .venv/bin/activate' before starting a Claude session
  - Required packages: pandas, numpy, matplotlib, statsmodels

  ### ACF Plotting
  - Use statsmodels.graphics.tsaplots.plot_acf() for autocorrelation plots
  - For better control, use: fig, ax = plt.subplots(figsize=(10, 4)); plot_acf(data, ax=ax, lags=20)
  - Confidence bands are automatically included (95% by default using ±1.96/√N)
  - Always add plt.tight_layout() and plt.show() for proper display in Quarto

  ### Code Chunk Options
  - Use #| echo: true to show code to students
  - Use #| echo: false to hide code (for setup or intermediate calculations)
  - Use #| eval: false to show code without executing
  - Use #| fig-width: 10 for a full width figure
  - Use #| fig-height: 4 for a full height figure
  - Quarto recognizes these comment-style options (not knitr-style chunk headers)

  ### Common Translation Patterns
  - R's I(Year^2) in formulas → Create new column: df['Year_sq'] = df['Year']**2
  - R's str(data) → Python's print(data.info()) and print(data.head())
  - R's plot(y~x, data=df, ty="l") → plt.plot(df['x'], df['y'], '-')
  - R's lines(x, y, col="red") → plt.plot(x, y, 'r-', label='...')
  - R's summary(lm_fit) → print(lm_fit.summary())
  - Matrix predictions: Z @ beta (preferred) or Z.dot(beta) or np.dot(Z, beta)

  ### LaTeX Equations in Quarto
  - Use \begin{equation} and \end{equation} instead of \[ and \]
  - Quarto/Beamer does not properly handle \[ \] in qmd files
  - For inline math, use $ $ as usual
  - For display math without numbering, use \begin{equation*} \end{equation*} in preference to $$ $$




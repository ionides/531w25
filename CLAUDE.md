
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
  - Also, learn from previously translated files: 01/py.qmd, 02/py.qmd, 03/py.qmd, 04/py.qmd, 05/py.qmd, 06/py.qmd
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
  - Time series models: R arima() → statsmodels.tsa.arima.model.ARIMA (for ARMA/ARIMA)
  - SARIMA models: R arima() with seasonal → statsmodels.tsa.statespace.sarimax.SARIMAX
  - Regression with ARMA errors: R arima() with xreg → SARIMAX() with exog parameter
  - ARMA simulations: R arima.sim() → statsmodels.tsa.arima_process.ArmaProcess.generate_sample()
  - ACF plots: R acf() → statsmodels.graphics.tsaplots.plot_acf
  - ADF test: R tseries::adf.test() → statsmodels.tsa.stattools.adfuller()
  - Linear regression: R lm() → statsmodels.formula.api.ols() or statsmodels.regression.linear_model.OLS
  - Matrix operations: R cbind() → np.column_stack(), R %*% → @ operator or np.dot()
  - Extract coefficients: R coef() → model.params (for statsmodels) or model.params.values (for numpy array)
  - Extract residuals: R resid() → model.resid
  - Polynomial roots: R polyroot(c(1,a,b)) → np.roots([b,a,1]) (note reversed order!)
  - Chi-squared quantiles: R qchisq(p, df) → stats.chi2.ppf(p, df) from scipy.stats
  - Parallel computing: R doParallel::foreach() → joblib.Parallel() with delayed() (requires: pip install joblib)

  ### Statsmodels Notes
  - The intercept/constant parameter is named 'const' (not 'intercept')
  - Access fitted parameters with model.params['param_name']
  - Access standard errors with model.bse['param_name']
  - For R-like formula syntax, use statsmodels.formula.api.ols('y ~ x1 + x2', data=df).fit()
  - The summary() method provides output similar to R's summary(lm())
  - When using formula API, need to manually create transformed variables (e.g., Year_sq = Year**2)
  - For formula API, variable names with special chars need quotes or preprocessing

  ### Statsmodels ARIMA Notes (Lessons from Chapter 5)
  - R's arima()$sigma2 → Python's model.scale (residual variance estimate)
  - Log likelihood: R's logLik(model) → model.llf in Python
  - ARIMA parameter indexing: model.params has order [AR coefficients, MA coefficients, intercept]
  - Access AR parameters: model.arparams (without the leading 1)
  - Access MA parameters: model.maparams (without the leading 1)
  - Profile likelihood: Exact parameter fixing is complex in statsmodels; approximate by using different start_params
  - AIC table construction: Iterate through (p,q) combinations, fit ARIMA(p,0,q), extract model.aic

  ### SARIMA and Regression with ARMA Errors (Lessons from Chapter 6)
  - **SARIMA models**: Use `statsmodels.tsa.statespace.sarimax.SARIMAX` (not ARIMA)
  - R's `arima(y, order=c(p,d,q), seasonal=list(order=c(P,D,Q), period=12))` → Python's `SARIMAX(y, order=(p,d,q), seasonal_order=(P,D,Q,12))`
  - Note: `seasonal_order` is a 4-tuple: (P, D, Q, period)
  - **Regression with ARMA errors**: R's `arima(y, order=c(p,d,q), xreg=X)` → Python's `SARIMAX(y, order=(p,d,q), exog=X)`
  - The `exog` parameter adds exogenous regressors (covariates) to the model
  - **Reshaping monthly data**: To convert wide-format monthly data (12 columns) to long format:
    - `huron_level = dat.iloc[:, 1:13].values.flatten()` (skip year column, take months)
    - Time index: `time = years + months/12` where years are repeated 12 times, months are 0-11
  - **ADF test**: R's `tseries::adf.test()` → Python's `statsmodels.tsa.stattools.adfuller()`
  - adfuller returns tuple: (test_statistic, p_value, lags_used, nobs, critical_values, icbest)

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

  ### Common Issues and Solutions (Lessons from Chapters 4-5)

  **CSV file column names with spaces:**
  - Issue: CSV files may have column names with leading/trailing spaces
  - Solution: After reading, use `dat.columns = dat.columns.str.strip()` to clean column names

  **Kernel density estimation with boundary-constrained data:**
  - Issue: scipy.stats.gaussian_kde() fails when data has zero variance (e.g., many values at boundary)
  - Error: "singular data covariance matrix" LinAlgError
  - Solution: Use histogram with `density=True` instead of KDE: `plt.hist(data, bins=30, density=True, alpha=0.7)`
  - Root cause: ARIMA may constrain MA coefficients to [-1,1] for invertibility, causing pile-up at boundaries

  **ARMA polynomial construction for simulations:**
  - For AR process with coefficient φ: `ar_poly = np.r_[1, -phi]` (note the negative sign)
  - For MA process with coefficient θ: `ma_poly = np.r_[1, theta]` (note the positive sign)
  - ArmaProcess expects polynomials in form: AR(B) = 1 - φ₁B - φ₂B², MA(B) = 1 + θ₁B + θ₂B²
  - Example: AR(1) with φ=0.6 → `ar_poly = np.r_[1, -0.6]`, `ma_poly = np.array([1])`

  **Package installation during translation:**
  - Some packages (e.g., joblib) may not be in the default environment
  - Install with: `pip install joblib` in the activated virtual environment
  - Add to import section: `from joblib import Parallel, delayed`

  **Simulation study best practices:**
  - Use try-except blocks around model fitting in loops to handle convergence failures
  - For compilation speed, reduce J (number of simulations) to 100-200 for echo=false chunks
  - Document the full J value in echo=true chunks so students see realistic simulation sizes
  - Sequential loops work well for reproducibility; mention parallel options in text




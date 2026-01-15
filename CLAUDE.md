
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
  - Also, learn from previously translated files: 01/py.qmd, 02/py.qmd, 03/py.qmd, 04/py.qmd, 05/py.qmd, 06/py.qmd, 07/py.qmd, 08/py.qmd, 09/py.qmd, 10/py.qmd, 11/py.qmd
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
  - **Spectral analysis** (Chapter 7):
    - Eigenvalue decomposition: R eigen() → np.linalg.eig()
    - FFT: R fft() → np.fft.fft() or scipy.fft.fft()
    - Periodogram: R spectrum() → scipy.signal.periodogram()
    - Smoothed periodogram: R spectrum() with spans → scipy.signal.welch()
    - AR spectrum estimation: R spectrum(method="ar") → Fit AutoReg model, compute spectrum from AR parameters

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

  ### Frequency Domain Analysis (Lessons from Chapter 7)
  - **Eigenvalue decomposition**: Use `np.linalg.eig(V)` which returns tuple (eigenvalues, eigenvectors)
  - **Periodogram**: Use `scipy.signal.periodogram(data, scaling='spectrum')` for power spectral density
    - Returns tuple: (frequencies, psd)
    - For log scale plotting: use `plt.semilogy(freqs, psd)`
  - **Smoothed periodogram**: Use `scipy.signal.welch()` for Welch's method (segments + windowing)
    - Parameters: `nperseg` controls segment length (e.g., `len(data)//4`)
    - Provides smoothing by averaging periodograms of overlapping segments
  - **AR-based spectrum estimation**: No direct equivalent to R's `spectrum(method="ar")`
    - Fit AR model with `AutoReg(data, lags=range(1,21))` and select order by AIC
    - Compute spectrum manually: `spectrum = sigma^2 / |1 - sum(phi_i * exp(-2πiωi))|^2`
  - **Tapering**: R's `spec.taper()` can be implemented with cosine taper at ends
    - Default tapers first/last 10% of data: `(1-cos(πn/Np))/2` for smoothing
  - **NaN handling**: Use `np.where(np.isnan(data), np.nanmean(data), data)` to replace NaN with mean

  ### Smoothing in Time and Frequency Domains (Lessons from Chapter 8)
  - **Loess/Lowess smoothing**: R's `loess(y~x, span=0.5)` → Python's `statsmodels.nonparametric.smoothers_lowess.lowess(y, x, frac=0.5)`
    - R's loess returns a model object with `$fitted` and `$x` attributes
    - Python's lowess returns a 2D numpy array with shape (n, 2): columns are [x_values, smoothed_y_values]
    - Extract smoothed values: `smoothed = lowess(y, x, frac=0.5)[:, 1]`
    - Extract x values: `x_smooth = lowess(y, x, frac=0.5)[:, 0]`
  - **Frequency response function**: Ratio of output spectrum to input spectrum
    - Compute: `freq_response = spectrum_output / spectrum_input`
    - Shows how smoother modifies different frequency components
    - Values < 1 indicate attenuation, > 1 indicate amplification
  - **Band-pass filtering**: Extract mid-range frequencies (e.g., business cycles)
    - Remove low frequencies (trend): `detrended = data - lowess(data, time, frac=large_span)[:, 1]`
    - Remove high frequencies (noise): `smoothed = lowess(data, time, frac=small_span)[:, 1]`
    - Extract band: `cycles = data - low_freq - high_freq`
  - **Time series decomposition**: Separate data into trend + cycles + noise using different smoothing spans
    - Trend: loess with large span (e.g., frac=0.5)
    - Noise: difference from loess with small span (e.g., frac=0.1)
    - Cycles: residual after removing both trend and noise
  - **Smoothing for spectrum estimation**: Vary `nperseg` parameter in `signal.welch()` for different smoothing levels
    - Larger nperseg → less smoothing, better frequency resolution
    - Smaller nperseg → more smoothing, less variance in estimates

  ### Case Study and Bivariate Time Series Analysis (Lessons from Chapter 9)
  - **Hodrick-Prescott filter**: R's `mFilter::hpfilter(x, freq=100)` → Python's `statsmodels.tsa.filters.hp_filter.hpfilter(x, lamb=100)`
    - Returns tuple: (cycle, trend) where cycle is the detrended component
    - Standard λ=100 for annual data to extract business cycle component
    - HP filter is a smoothing spline that minimizes sum of squared residuals plus penalty on second differences
  - **Named parameters in SARIMAX**: To access parameters by name instead of position:
    - Convert exog to pandas DataFrame with column names: `exog_df = pd.DataFrame(exog, columns=['var_name'])`
    - Pass DataFrame to SARIMAX: `SARIMAX(y, exog=exog_df, order=(p,d,q))`
    - Access parameters by name: `model.params['var_name']` and `model.bse['var_name']`
    - AR parameters: `model.params['ar.L1']`, `model.params['ar.L2']`, etc.
    - MA parameters: `model.params['ma.L1']`, `model.params['ma.L2']`, etc.
  - **Cross-correlation function (CCF)**: R's `ccf(x, y)` → Compute manually in Python
    - Formula: `ccf = np.correlate(x - x.mean(), y - y.mean(), mode='full') / (len(x) * x.std() * y.std())`
    - Lags: `lags = np.arange(-(len(x)-1), len(x))`
    - Plot with stem plot and confidence bands at ±1.96/√N
  - **Cross-spectrum and coherence**: Use `scipy.signal.csd()` for cross-spectral density
    - Cross-spectrum: `freqs, Pxy = signal.csd(x, y, nperseg=...)`
    - Marginal spectra: `freqs, Pxx = signal.welch(x, nperseg=...)` and similar for y
    - Squared coherence: `coherence_sq = np.abs(Pxy)**2 / (Pxx * Pyy)`
    - Phase: `phase = np.angle(Pxy)`
  - **Dual-axis plotting**: Use `ax.twinx()` for two y-axes
    - Create primary axis: `fig, ax1 = plt.subplots()`
    - Plot first series: `ax1.plot(x, y1, 'k-')`
    - Create secondary axis: `ax2 = ax1.twinx()`
    - Plot second series: `ax2.plot(x, y2, 'r-')`
    - Set labels and colors for both axes
  - **LaTeX math operators**: Define custom operators like \argmin in header
    - Add to header-includes: `\DeclareMathOperator*{\argmin}{argmin}`
    - Required for beamer/LaTeX compilation

  ### Forecasting (Lessons from Chapter 10)
  - **ARIMA/SARIMA forecasting**: R's `predict.Arima()` → Python's `.get_forecast()` method
    - After fitting: `model = SARIMAX(data, order=(p,d,q), seasonal_order=(P,D,Q,s)).fit()`
    - Forecast: `forecast = model.get_forecast(steps=h)` where h is horizon
    - Get predictions: `forecast.predicted_mean` for point forecasts
    - Get standard errors: `forecast.se_mean` for forecast uncertainty
    - Confidence intervals: `predicted_mean ± 1.96 * se_mean` for 95% intervals
  - **Prophet forecasting**: Facebook's Prophet available in both R and Python
    - Python package: `from prophet import Prophet`
    - Requires DataFrame with columns 'ds' (dates) and 'y' (values)
    - Create dates: `pd.date_range(start='YYYY-MM-DD', periods=n, freq='MS')` for monthly data
    - Fit model: `model = Prophet(); model.fit(dataframe)`
    - Make future dates: `future = model.make_future_dataframe(periods=h, freq='MS')`
    - Forecast: `forecast = model.predict(future)`
    - Plot: `model.plot(forecast)` returns matplotlib figure
  - **Time series forecasting patterns**:
    - Prophet is good for high-frequency data (daily, hourly) with strong seasonal patterns
    - SARIMA is good for monthly/quarterly data with moderate seasonality
    - Prophet handles missing data and outliers automatically
    - Prophet allows adding custom seasonality and holidays
  - **Forecast evaluation**:
    - Point forecast error: squared error, absolute error, MAPE
    - Probabilistic forecast: log-likelihood or log predictive density
    - One-step-ahead forecast log-density sums to total log-likelihood

  ### Theoretical Chapters and LaTeX Macros (Lessons from Chapter 11)
  - **Theoretical chapters**: Some chapters contain only mathematical theory with no data analysis or Python code
    - Chapter 11 is a pure theory chapter on POMP (Partially Observed Markov Process) models
    - Still requires translation from main.Rnw to py.qmd, focusing on LaTeX mathematical content
  - **LaTeX macro definitions for subscripted variables**: When defining macros for mathematical notation that will have additional subscripts:
    - **CORRECT**: Include the base subscript in the macro definition itself
      - Example: `\newcommand{\SigmaX}{\boldsymbol{\Sigma}_{X}}`
      - Usage: `\SigmaX_{n}` expands to `\boldsymbol{\Sigma}_{X}_{n}` (valid LaTeX)
    - **INCORRECT**: Define macro with subscript variable outside braces
      - Example: `\newcommand{\SigmaX}{\boldsymbol{\Sigma}_X}` (wrong!)
      - Usage: `\SigmaX_{n}` expands to `\boldsymbol{\Sigma}_X_{n}` (double subscript error!)
    - This pattern applies to any mathematical notation with nested subscripts (covariance matrices, indexed variables, etc.)
  - **Required LaTeX packages and operators for POMP theory**:
    - Custom operators: `\DeclareMathOperator*{\argmin}{argmin}` and `\argmax`
    - Conditional probability notation: `\newcommand{\given}{\,|\,}` for better spacing in P(A|B)
    - Parameter separator: `\newcommand{\params}{;\,}` for semicolon in distributions
    - Distribution names: `\newcommand{\normal}{\mathrm{N}}` for normal distribution
    - Matrix notation: `\newcommand{\matA}{\mathbf{A}}` for state transition matrices
  - **Empty Python code chunks**: Even theoretical chapters need an empty Python setup chunk:
    ```python
    #| echo: false
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    ```
    This prevents Quarto from complaining about missing code execution.

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




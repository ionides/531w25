Project Tycho dataset documentation
Project Tycho version 2.0

Documentation
-------------
Last updated: 2018-06-25

Content:
1. Origin of datasets
2. Information about dataset format
3. Suggested data management before analysis
4. User license information
5. Citation
6. Contact information

-------------
1. ORIGIN OF DATASETS
Project Tycho datasets contain information from external sources of disease surveillance data, such as the United States Centers for Disease Control or the World Health Organization. Data from some sources were already in the public domain, whereas data from other sources were not public before inclusion in Project Tycho datasets. The Project Tycho team has obtained permission for redistribution of data that was not previously public, from agencies that collected and owned the data. All pre-compiled Project Tycho datasets contain count data that are identical to counts published in the original source and no counts have been modified in any way by the Project Tycho team. The Project Tycho team has curated datasets by adding new variables, such as standard identifiers for reported conditions, locations, and pathogens, and by re-representing reported information in a standard data format.

2. INFORMATION ABOUT DATASET FORMAT
Project Tycho datasets in version 2.0 are formatted according to a standard data format, i.e. a comma separated file with 20 variables. This format can be viewed at www.tycho.pitt.edu/dataformat and at https://fairsharing.org/bsg-s000718.

3. SUGGESTED DATA MANAGEMENT BEFORE ANALYSIS
Project Tycho datasets contain case counts for a specific condition (e.g. measles) and country (e.g. United States) reported for time intervals. In addition to case counts, datasets include information about these counts (attributes), such as the location, age group, subpopulation, diagnostic certainty, place of acquisition, and the source from which we obtained case counts. One dataset can include many time series of case count intervals, i.e. for each combination of attributes, such as measles cases for 0-5 years old, with probable diagnosis, domestic acquisition, reported by the US CDC. Depending on the user purpose, we recommend the following data processing steps before analysis:
- Analyze missing data: Project Tycho datasets do not include time intervals for which no case count was reported (count time series in datasets are often incomplete) and users will need to add time intervals for which no count value is available. Project Tycho datasets do include time intervals for which a case count value of zero was reported.
- Separate cumulative from non-cumulative time interval series. Project Tycho case count time series can be in a cumulative or fixed-interval format. Cumulative case count time series consist of overlapping case count intervals starting on the same date, but ending on different dates. Cumulative case count time series result from case reporting for "all previous weeks" instead of "the most recent week only". An example of a cumulative case count time series is:
	- time interval 1: Jan 1-Jan 7: 10 cases
	- time interval 2: Jan 1-Jan 14: 15 cases
	- time interval 3: Jan 1-Jan 21: 17 cases
	- etc.

Fixed-interval case count time series consist of mutually exclusive time intervals that all start and end on different date and all have identical length (day, week, month, year), for example:
	- time interval 1: Jan 1-Jan 7: 10 cases
	- time interval 2: Jan 8-Jan 14: 7 cases
	- time interval 3: Jan 15-Jan 21: 3 cases
	- etc.

4. USER LICENSE INFORMATION
Project Tycho datasets are available under a Creative Commons Attribution 4.0 International License (CC BY 4.0), see www.tycho.pitt.edu/license and https://creativecommons.org/licenses/by/4.0/. The CC BY 4.0 requires that users cite Project Tycho datasets as suggested below. 

5. CITATION
Van Panhuis, W., Cross, A., Burke, D., Counts of Malaria reported in UNITED STATES OF AMERICA: 1951-2017 (version 2.0, April 1, 2018): Project Tycho data release, DOI: 10.25337/T7/ptycho.v2.0/US.61462000

6. CONTACT INFORMATION
In case of questions or ideas, please contact Project Tycho via email (tycho@phdl.pitt.edu) or via the website (www.tycho.pitt.edu).


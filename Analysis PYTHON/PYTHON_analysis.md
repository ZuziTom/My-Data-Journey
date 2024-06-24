# Python Skills for Data Analysis

## 1. Basic Python: Functions, Lists, Dictionaries, Strings
- Functions: def, return, lambda functions
- Lists: append(), extend(), remove(), pop(), sort(), reverse(), list comprehensions
- Dictionaries: keys(), values(), items(), get(), update()
- Strings: upper(), lower(), strip(), replace(), split(), f-strings

## 2. Advanced Python: OOP, Files, Exceptions, Regular Expressions
- OOP: Classes, objects, inheritance, methods, attributes
- Files: open(), read(), write(), close(), context managers (with open() as)
- Exceptions: try, except, finally, custom exceptions
- Regular Expressions: re.search(), re.match(), re.findall(), re.sub()

## 3. Python and PostgreSQL
- psycopg2 library
- Basic Data Operations: Loading, replacing, deleting data
- Statistical Calculations: mean(), min(), max(), relationships, aggregate functions, multiple grouping

## 4. API and JSON
- Requests, JSON library
- Authentication: Handling API keys and tokens
- API Requests: requests.get(), requests.post()
- JSON: json.loads(), json.dumps(), parsing and manipulating JSON data

## 5. Pandas
- Loading Data: pd.read_csv(), pd.read_excel()
- DataFrame:
  - Creation: pd.DataFrame(), pd.Series()
  - Getting Familiar with df: shape, head(), tail(), info(), columns
  - Manipulation/Selecting/Filtering: .loc[], .iloc[], .isin(), .filter()
  - Handling Missing Values: df.dropna(), df.fillna(), isna() / isnull()
  - Duplicates: df.duplicated(), df.drop_duplicates()
  - Modifying Columns: .rename(), .drop(), replace(),insert(), astype()
  - Adding Columns: df['new_column'] = values, insert(), concat(), assign()
- Descriptive Statistics: mean(), median(), std(), min(), max(), quantile(), df.describe()
- Grouping and Aggregations: groupby(), agg()
- Merge: pd.merge(), pd.concat()
- Working with Datetime: to_datetime(), df['date'].dt.year
- Pivot Tables: pivot_table()
- Openpyxl Library: File conversion, grouping across sheets
- Analytical Functions: cumsum(), cummax(), cummin(), cumcount()

## 6. Web Scraping
- HTML and URLs: Basic structure and handling
- BeautifulSoup: soup.find(), soup.find_all(), extracting and parsing HTML data
- Selenium: Automating web interactions, retrieving dynamic content

## 7. Data Visualization
- Matplotlib:
  - Basic Plots: plt.figure(), plt.plot(), plt.show()
  - Advanced Plots: Bar plot, Histogram, Pie plot, Scatter plot
  - Multiple Plots: plt.subplot(), plt.subplot2grid()
  - Additional Elements: Arrows, Error bars, Additional lines, Annotations, Background images
- Seaborn: Statistical plots and advanced visualizations
- Pandas Plotting: Built-in plotting capabilities
- Bokeh: Interactive visualizations

## 8. PDF Creation
- ReportLab Library: Generating PDF files, formatting text, adding tables


# FINAL PROJECT

### Project Aim and Description
A data analyst, responsible for collecting, storing, and interpreting data, as well as creating recommendations, is part of a team facing a growing number of tasks. To address this increase in workload, the team has decided to hire new personnel for the following positions:
- Data Analyst
- Data Engineer
- Data Scientist

### The objective is to enhance the efficiency of providing recommendations to an internal client. To support the hiring process, the HR team has requested the following information:
- Estimated cost of hiring for the mentioned positions.
- Pay range for each position.
- Cities where suitable candidates can be hired.
- Assessment of whether the team can be formed in a single city.
- The job offers will be posted on NoFluffJobs, and the analysis will be based on data from this website. The website offers options to change the interface language and localization, which can aid in familiarizing with it.

### Draft of Workshop Progress
The task will be executed using the following modules:
- Selenium: For retrieving information about currently active job offers.
- BeautifulSoup: For transforming unstructured data (HTML code) into tabular data (DataSet).
- Pandas: For data transformation.
- Matplotlib: For presenting results.

### Project Structure
To simplify work during the workshop and ensure easy collaboration, a consistent project structure called cookiecutter Data Science was used. Structure has been simplified to avoid unnecessary hassle.

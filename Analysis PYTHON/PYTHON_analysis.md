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


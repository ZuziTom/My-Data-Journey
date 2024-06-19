Python Skills for Data Analysis


1. Basic Python: Functions, Lists, Dictionaries, Strings
•	Functions: def, return, lambda functions
•	Lists: append(), extend(), remove(), pop(), sort(), reverse(), list comprehensions
•	Dictionaries: keys(), values(), items(), get(), update()
•	Strings: upper(), lower(), strip(), replace(), split(), f-strings
2. Advanced Python: OOP, Files, Exceptions, Regular Expressions
•	OOP: Classes, objects, inheritance, methods, attributes
•	Files: open(), read(), write(), close(), context managers (with open() as)
•	Exceptions: try, except, finally, custom exceptions
•	Regular Expressions: re.search(), re.match(), re.findall(), re.sub()
3. Python and PostgreSQL
•	Basic Data Operations: Loading, replacing, deleting data
•	Statistical Calculations: mean(), min(), max(), relationships, aggregate functions, multiple grouping
4. API and JSON
•	Authentication: Handling API keys and tokens
•	API Requests: requests.get(), requests.post()
•	JSON: json.loads(), json.dumps(), parsing and manipulating JSON data
5. Pandas
•	Loading Data: pd.read_csv(), pd.read_excel()
•	DataFrame and Series: Creation, manipulation
•	Descriptive Statistics: mean(), median(), std()
•	Filtering Data: df[df['column'] > value]
•	Selecting Data: .loc[], .iloc[]
•	Data Processing: Modifying columns, handling missing values, duplicates
o	Max, Min: df['column'].max(), df['column'].min()
o	Duplicates: df.duplicated(), df.drop_duplicates()
o	Adding Columns: df['new_column'] = values
o	Grouping and Aggregations: df.groupby('column').agg({'column': ['sum', 'mean']})
o	Merge: pd.merge()
o	Normalization: (df['column'] - df['column'].mean()) / df['column'].std()
o	Working with Datetime: pd.to_datetime(), df['date'].dt.year
o	Pivot Tables: pd.pivot_table()
o	Openpyxl Library: File conversion, grouping across sheets
o	Analytical Functions: cumsum(), cummax(), cummin(), cumcount()
6. Web Scraping
•	HTML and URLs: Basic structure and handling
•	BeautifulSoup: soup.find(), soup.find_all(), extracting and parsing HTML data
•	Selenium: Automating web interactions, retrieving dynamic content
7. Data Visualization
•	Matplotlib:
o	Basic Plots: plt.figure(), plt.plot(), plt.show()
o	Advanced Plots: Bar plot, Histogram, Pie plot, Point plot
o	Multiple Plots: plt.subplot(), plt.subplot2grid()
o	Additional Elements: Arrows, Error bars, Additional lines, Annotations, Background images
•	Seaborn: Statistical plots and advanced visualizations
•	Pandas Plotting: Built-in plotting capabilities
•	Bokeh: Interactive visualizations
8. PDF Creation
•	ReportLab Library: Generating PDF files, formatting text, adding tables


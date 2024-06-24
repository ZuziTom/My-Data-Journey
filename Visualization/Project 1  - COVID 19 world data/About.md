# Data Visualization Project

## Overview
This project consolidates course knowledge. As a data analyst, you'll visualize COVID-19 data.

## Requirements
Language: Python
Libraries: seaborn, plotly, dash, google.colab, threading
Environment: Google Colab
Dataset: project_1_python.csv (COVID-19 data from Our World In Data)
Objective
Analyze and visualize the COVID-19 pandemic.

## Solution Format
Submit an exported notebook in *.ipynb format.


## Content
1. Used seaborn library in Python to rank and visualize the top 10 countries by population from a dataset. Enhanced readability of the bar plot by adjusting figure size, applying whitegrid style, and rotating x-axis labels
2. Utilized the plotly library in Python to visualize the relationship between population and life expectancy in countries. Adjusted the appearance by setting the X axis to a logarithmic scale and coloring markers based on the continent using a custom color palette, while also adding an appropriate title to the chart.
3. Used the plotly library in Python to create a visualization comparing the distribution of new COVID-19 cases over time between two chosen countries. Enhanced the appearance by coloring markers based on the respective country, utilizing a custom color palette, and added a descriptive title to the chart.
4. Utilized the plotly library in Python to create a world map visualization depicting reported disease cases in each country throughout the pandemic. Colored markers based on continents, adjusted marker size relative to the ratio of cases to population, set initial zoom to display the entire world map, controlled maximum marker size for readability, and configured tooltips to display country name and case information.
5. Dashboard #1 : Create two side-by-side visualizations using Plotly and Dash:
- Line chart for cumulative COVID-19 cases over time.
- Line chart for cumulative COVID-19 deaths over time.
Include a dynamically updated title based on the selected country. Implement a country filter to view charts for the selected country only.
6. Dashboard #2 : Create a dashboard with one visualization using Plotly and Dash:
- A map using Mapbox's dark style, displaying markers (circles) of countries based on selected filters.
- Marker size varies based on the selected metric (e.g., total cases, deaths).
Include a title that updates based on the selected filters, following the pattern: "COVID-19 - {metric} in {continent}". Provide two filters: Select continent & Select metric (total cases, total deaths, total tests, total vaccinations, total vaccinated people). Display titles (labels) for each filter. Ensure that hovering over a marker shows the country name, coordinates, and selected metric. This setup allows users to dynamically explore COVID-19 metrics across continents using an interactive map visualization in the dashboard.
7. Dashboard #3 : Create a dashboard with two side-by-side visualizations using Plotly and Dash:
- Column chart displaying the largest values of total number of vaccinations for n selected countries, ordered in descending order.
- Column chart displaying the largest values of the ratio of total number of vaccinations to population for n selected countries, also in descending order.
This setup enables users to dynamically explore and compare COVID-19 vaccination data across multiple countries based on their chosen parameter settings.

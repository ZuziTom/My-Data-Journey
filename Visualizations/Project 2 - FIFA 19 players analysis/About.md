## Project Overview:

Tool: Tableau Public
Dataset: FIFA19 footballers dataset from Kaggle (files: fifa_players.csv and fifa_players_statistics.csv)
Problem: Analyzing financial data and skill profiles of footballers in the game.
Solution: Create a series of dashboards and visualizations on Tableau Public.

## Dataset Description:
- fifa_players.csv: Contains general information about FIFA19 footballers, including attributes like age, nationality, club, and market value.
- fifa_players_statistics.csv: Provides detailed statistics about each player's skills and performance metrics within the game.


## Key Elements:
Consistent Appearance: Maintain uniformity in visual elements such as font types and color schemes across all dashboards to ensure cohesive storytelling.

## Project Deliverables:

- Dashboards: Compose a narrative using multiple dashboards in Tableau Public that explore:
- Financial insights (e.g., market value distribution, salary comparisons).
- Skill profiles (e.g., player ratings, position-specific skills).
- Comparative analysis (e.g., top players by various metrics, club comparisons).

## Objective:
Used Tableau's visualization capabilities to uncover trends, insights, and comparisons within the FIFA19 footballers dataset, enhancing understanding of player attributes and performance metrics.


# OUTCOME:
- https://public.tableau.com/views/FIFA19analysis_17149145209880/Story1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link

## CONTENT

1. Ranking visualization of FIFA19 players based on wage amount, market value, and release clause value using Tableau, monetary amounts with the euro symbol (€),  Implement a drop-down filter for selecting specific player positions
2. Create a choropleth map focusing on nationalities. Display and compare the number of soccer players from different countries, identifying the country with the highest count using the Id column.
3. Create a column chart to show statistics on the value of football players according to their age. Add a parameter with options for Maximum, Minimum, Average, and Median values.Create a calculated field that dynamically computes statistics (MAX, MIN, AVG, MEDIAN) based on the selected parameter. This setup allows for an interactive column chart in Tableau where users can dynamically view statistics (maximum, minimum, mean, median) of football player values by age, controlled via a parameter.
4. Create a scatter plot of the overall rating of football players against their age, treating these as dimensions. Customize the scatter plot so each point represents player count, with color and size varying based on player quantity.
5. Create a packed bubbles. Markers: Include player's full name and overall rating.
Marker Size: Size should reflect player earnings. Filter: Add a drop-down filter to select teams. Clustering: Utilize a clustering algorithm to group players into 4 clusters based on earnings and overall rating, using the Color Blind color palette. Labels: Configure labels in Marks to display the Cluster variable above the Name and SUM(Overall) variables.
6. Build a table in Tableau with four dimensions: club name, player's name, preferred playing leg (left/right), and position on the field. Metrics: Include each player's release clause as the metric. Sorting: Sort the table in descending order based on the release clause amount to display the largest to smallest values.
7. Create a story where you are going to add four dashboards.

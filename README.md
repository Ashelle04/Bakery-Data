# Bakery Data Analysis

This repository contains R code for analyzing bakery sales data. The analysis is conducted to gain insights into various aspects of the bakery business, including sales trends, dessert preferences, and the impact of promotions.

## Dataset
The dataset used for this analysis contains information about daily sales from a bakery. It includes variables such as Date, Day of the Week, Dessert Type (Cakes, Pies, Cookies, Smoothies, Coffee), and information about promotions.

## Analysis Overview

### Analysis Without ggplot and melt Function

1. **Dessert Sales by Weekday vs. Weekend**
   - Calculated the average sales of each dessert on weekdays and weekends.
   - Identified desserts with the biggest difference in averages between the two groups.

2. **Monthly Average Sales by Dessert**
   - Calculated the average monthly sales for each dessert.
   - Identified the dessert with the highest monthly average sales.

3. **Seasonal Dessert Sales**
   - Calculated the average sales of each dessert during the summer months (June-August) and non-summer months.
   - Identified desserts with the biggest and least difference in averages between the two groups.

### Analysis With ggplot and melt Function

1. **Dessert Sales by Month**
   - Used the melt function to reshape the data.
   - Calculated the average sales of each dessert by month.
   - Plotted a bar graph showing the monthly averages of desserts.

2. **Monthly Average Dessert Sales**
   - Plotted a box plot to visualize the distribution of average dessert sales by month.
   - Created a bar graph to show the monthly averages of all desserts.

3. **Average Dessert Sales Across 12 Months**
   - Plotted a line graph to visualize the average sales of desserts across the 12 months.

4. **Promotion Analysis**
   - Analyzed the impact of promotions on dessert sales.
   - Plotted bar graphs to compare the average sales of desserts with and without promotions.

## Visualizations
Below are some visualizations generated from the analysis:

![Monthly Dessert Sales]([path/to/monthly_dessert_sales.png](https://github.com/Ashelle04/sample-images-/blob/main/Rplot02.jpeg))

![Promotion Impact]([path/to/promotion_impact.png](https://github.com/Ashelle04/sample-images-/blob/main/Rplot02.jpeg))
![Promotion Impact2](![Promotion Impact]([path/to/promotion_impact.png](https://github.com/Ashelle04/sample-images-/blob/main/Rplot02.jpeg)))

## Usage
To reproduce the analysis:
1. Clone this repository.
2. Ensure you have R and necessary packages installed.
3. Run the R scripts provided in the repository.

## License
This project is licensed under the [MIT License](LICENSE).


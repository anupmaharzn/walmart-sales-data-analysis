## Purpose of the Project

### The major aim of the project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

# ABOUT DATA

| column | description  | data type  |
| :-----: | :-: | :-: |
| invoice_id | Invoice of the sales made  |  VARCHAR(30) |
| branch | Branch at which sales were made |  VARCHAR(5) |
| city | The location of the branch |  VARCHAR(30) |
| customer_type |  The type of the customer | VARCHAR(30) |
| gender |  Gender of the customer making purchase | VARCHAR(10) |
| product_line | Product line of the product self | VARCHAR(100) |
| unit_price |  The price of each product | NUMBER(10, 2) |
| quantity |  The amount of the product sold |  NUMBER |
| VAT | The amount of tax on the purchase | NUMBER(6, 4) |
| total | The total cost of the purchase  | NUMBER(10, 2) |
| date | The date on which the purchase was made  | DATE |
| time | The time at which the purchase was made | TIMESTAMP |
| payment  | The total amount paid | NUMBER(10, 2) |
| cogs | Cost Of Goods sold | NUMBER(10, 2) |
| gross_margin_ptg  | Gross margin percentage |  NUMBER(11, 9) |
| gross_income | Gross Income | NUMBER(10, 2) |
| rating | Rating |  NUMBER(2, 1) |

## analysis list

# product analysis

-Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

# sales analysis

-This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

# customer analysis

-This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Business Questoin to Answer

# Generic Question

- How many unique cities does the data have?
- In which city is each branch?

# product

- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
- Which branch sold more products than average product sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

# sales

- Number of sales made in each time of the day per weekday
- Which of the customer types brings the most revenue?
- Which city has the largest tax percent/ VAT (Value Added Tax)?
- Which customer type pays the most in VAT?

# customer

- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- Which customer type buys the most?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- Which time of the day do customers give most ratings?
- Which time of the day do customers give most ratings per branch?
- Which day fo the week has the best avg ratings?
- Which day of the week has the best average ratings per branch?

## Revenue And Profit Calculations

$ COGS = unitPrice \* quantity

$ VAT = 5% \* COGS
- is added to the
and this is what is billed to the customer.

$ Total (Gross Sales) = VAT + COGS
- This represents the total amount billed to the customer, including the COGS and VAT.

$ grossProfit(grossIncome) = total(gross_sales) - COGS $
- Gross Profit is the profit earned after deducting the cost of goods sold (COGS) and is also known as gross income.

$ gross Margin = (Gross Profit / Total Revenue (Gross Sales))
- Gross Margin is expressed as a percentage of the total revenue, indicating the profitability of the company's core operations.



-- CASE SCENARIO I

-- 1. Product category with highest sales
SELECT [Product Category], SUM(Sales) AS Total_Sales
FROM KMS_Cleaned
GROUP BY [Product Category]
ORDER BY Total_Sales DESC;

-- 2. Top 3 and Bottom 3 regions by sales
-- Top 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_Cleaned
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Bottom 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_Cleaned
GROUP BY Region
ORDER BY Total_Sales ASC;

-- 3. Total sales of appliances in Ontario
SELECT SUM(Sales) AS Total_Sales_Appliances_Ontario
FROM KMS_Cleaned
WHERE [Product Sub-Category] = 'Appliances' AND Province = 'Ontario';

-- 4. Bottom 10 customers by total sales
SELECT TOP 10 [Customer Name], SUM(Sales) AS Total_Sales
FROM KMS_Cleaned
GROUP BY [Customer Name]
ORDER BY Total_Sales ASC;

-- 5. Shipping method with the highest total shipping cost
SELECT [Ship Mode], SUM([Shipping Cost]) AS Total_Shipping_Cost
FROM KMS_Cleaned
GROUP BY [Ship Mode]
ORDER BY Total_Shipping_Cost DESC;

-- CASE SCENARIO II

-- 6. Most valuable customers and their most frequent products
WITH CustomerSales AS (
  SELECT [Customer Name], SUM(Sales) AS Total_Sales
  FROM KMS_Cleaned
  GROUP BY [Customer Name]
)
SELECT TOP 10 cs.[Customer Name], cs.Total_Sales, kc.[Product Name]
FROM CustomerSales cs
JOIN KMS_Cleaned kc ON cs.[Customer Name] = kc.[Customer Name]
ORDER BY cs.Total_Sales DESC;

-- 7. Small business customer with highest sales
SELECT TOP 1 [Customer Name], SUM(Sales) AS Total_Sales
FROM KMS_Cleaned
WHERE [Customer Segment] = 'Small Business'
GROUP BY [Customer Name]
ORDER BY Total_Sales DESC;

-- 8. Corporate customer with most orders
SELECT TOP 1 [Customer Name], COUNT([Order ID]) AS Total_Orders
FROM KMS_Cleaned
WHERE [Customer Segment] = 'Corporate'
GROUP BY [Customer Name]
ORDER BY Total_Orders DESC;

-- 9. Most profitable consumer customer
SELECT TOP 1 [Customer Name], SUM(Profit) AS Total_Profit
FROM KMS_Cleaned
WHERE [Customer Segment] = 'Consumer'
GROUP BY [Customer Name]
ORDER BY Total_Profit DESC;

-- 10. Customers who returned items (assumed from negative profit)
SELECT DISTINCT [Customer Name], [Customer Segment]
FROM KMS_Cleaned
WHERE Profit < 0;

-- 11. Shipping cost appropriateness based on order priority
SELECT [Order Priority], [Ship Mode], COUNT(*) AS Order_Count, SUM([Shipping Cost]) AS Total_Shipping_Cost
FROM KMS_Cleaned
GROUP BY [Order Priority], [Ship Mode]
ORDER BY [Order Priority], Total_Shipping_Cost DESC;


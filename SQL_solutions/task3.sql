-- =============================================
-- Task 3
-- Goal: one row per client, monthly totals in separate columns.
-- =============================================
SELECT
    c.FirstName + ' ' + c.LastName AS client,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 1  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS January,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 2  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS February,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 3  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS March,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 4  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS April,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 5  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS May,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 6  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS June,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 7  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS July,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 8  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS August,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 9  THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS September,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 10 THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS October,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 11 THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS November,
    CAST(SUM(CASE WHEN MONTH(o.OrderDate) = 12 THEN o.Amount ELSE 0 END) AS decimal(10, 2)) AS December
FROM CLIENTS AS c
LEFT JOIN ORDERS AS o
    ON o.ClientID = c.ClientID
GROUP BY
    c.ClientID,
    c.FirstName,
    c.LastName
ORDER BY
    client;

-- Possible improvement:
-- If date range grows, add a WHERE by year and index ORDERS(OrderDate, ClientID).
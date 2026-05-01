-- =============================================
-- Task 1
-- Goal: aggregate orders by day and by month.
-- Notes:
-- - OrderCount counts all orders
-- - TotalAmount includes only 'cash' orders
-- =============================================
WITH agg AS (
    SELECT
        o.ClientID,
        CAST(o.OrderDate AS date) AS PeriodDate,
        'Daily' AS Period,
        COUNT(*) AS OrderCount,
        SUM(CASE WHEN o.Description = 'cash' THEN o.Amount ELSE 0 END) AS TotalAmount
    FROM ORDERS o
    GROUP BY o.ClientID, CAST(o.OrderDate AS date)

    UNION ALL

    SELECT
        o.ClientID,
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1) AS PeriodDate,
        'Monthly' AS Period,
        COUNT(*) AS OrderCount,
        SUM(CASE WHEN o.Description = 'cash' THEN o.Amount ELSE 0 END) AS TotalAmount
    FROM ORDERS o
    GROUP BY o.ClientID, YEAR(o.OrderDate), MONTH(o.OrderDate)
)
SELECT TOP (20)
    c.FirstName + ' ' + c.LastName AS FullName,
    a.OrderCount,
    FORMAT(a.TotalAmount, '0.00') AS TotalAmount,
    CASE
        WHEN a.Period = 'Daily' THEN FORMAT(a.PeriodDate, 'dd-MM-yyyy')
        ELSE FORMAT(a.PeriodDate, 'MM-yyyy')
    END AS Period_of_Results,
    a.Period
FROM agg AS a
JOIN CLIENTS AS c
    ON c.ClientID = a.ClientID
ORDER BY
    a.OrderCount DESC,
    CASE WHEN a.Period = 'Daily' THEN 0 ELSE 1 END,
    c.FirstName + ' ' + c.LastName ASC,
    a.PeriodDate DESC;

-- Possible improvement:
-- Add index on ORDERS(ClientID, OrderDate) INCLUDE (Amount, Description).
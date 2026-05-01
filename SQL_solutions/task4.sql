-- =============================================
-- Task 4
-- Goal: totals by city/month + city totals + grand total.
-- =============================================
WITH src AS (
    SELECT
        a.City,
        MONTH(o.OrderDate) AS MonthNum,
        o.Amount
    FROM ORDERS AS o
    JOIN ADDRESSES AS a
        ON a.ClientID = o.ClientID
)
SELECT
    CASE WHEN GROUPING(s.City) = 1 THEN 'Total' ELSE s.City END AS City,
    CASE WHEN GROUPING(s.MonthNum) = 1 THEN 'Total' ELSE CAST(s.MonthNum AS varchar(2)) END AS [Month],
    CAST(SUM(s.Amount) AS decimal(10, 2)) AS TotalAmount
FROM src AS s
GROUP BY ROLLUP (s.City, s.MonthNum)
ORDER BY
    CASE WHEN GROUPING(s.City) = 1 THEN 1 ELSE 0 END,
    s.City,
    CASE WHEN GROUPING(s.MonthNum) = 1 THEN 1 ELSE 0 END,
    s.MonthNum;

-- Possible improvement:
-- Replace MonthNum with month name in a presentation layer if needed.

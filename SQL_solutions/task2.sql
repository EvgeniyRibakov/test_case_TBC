-- =============================================
-- Task 2
-- Goal: total orders and amount per city,
-- plus top customer by amount in each city.
-- =============================================
WITH city_totals AS (
    SELECT
        a.City,
        COUNT(*) AS OrderCount,
        SUM(o.Amount) AS TotalAmount
    FROM ORDERS AS o
    JOIN ADDRESSES AS a
        ON a.ClientID = o.ClientID
    GROUP BY
        a.City
),
city_customer_totals AS (
    SELECT
        a.City,
        o.ClientID,
        SUM(o.Amount) AS CustomerAmount
    FROM ORDERS AS o
    JOIN ADDRESSES AS a
        ON a.ClientID = o.ClientID
    GROUP BY
        a.City,
        o.ClientID
),
ranked_customers AS (
    SELECT
        cct.City,
        c.FirstName + ' ' + c.LastName AS TopCustomer,
        ROW_NUMBER() OVER (
            PARTITION BY cct.City
            ORDER BY cct.CustomerAmount DESC, cct.ClientID DESC
        ) AS rn
    FROM city_customer_totals AS cct
    JOIN CLIENTS AS c
        ON c.ClientID = cct.ClientID
)
SELECT
    ct.City,
    ct.OrderCount,
    CAST(ct.TotalAmount AS decimal(10, 2)) AS TotalAmount,
    rc.TopCustomer
FROM city_totals AS ct
JOIN ranked_customers AS rc
    ON rc.City = ct.City
    AND rc.rn = 1
ORDER BY
    ct.OrderCount DESC,
    ct.TotalAmount DESC;

-- Possible improvement:
-- Add index on ADDRESSES(ClientID, City) for faster joins/grouping.

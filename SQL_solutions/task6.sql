-- =============================================
-- Task 6
-- Goal: generate all dates between @start and @end into a new table.
-- =============================================
DECLARE @start date = '2020-01-01';
DECLARE @end date = '2023-01-01';

IF OBJECT_ID('dbo.Days_in', 'U') IS NOT NULL
    DROP TABLE dbo.Days_in;

CREATE TABLE dbo.Days_in (
    Days_in date NOT NULL
);

;WITH d AS (
    SELECT @start AS dt
    UNION ALL
    SELECT DATEADD(day, 1, dt)
    FROM d
    WHERE dt < @end
)
INSERT INTO dbo.Days_in (Days_in)
SELECT dt
FROM d
OPTION (MAXRECURSION 0);

SELECT Days_in
FROM dbo.Days_in
ORDER BY Days_in;

-- Possible improvement:
-- Use a calendar table for reusable date ranges in larger projects.

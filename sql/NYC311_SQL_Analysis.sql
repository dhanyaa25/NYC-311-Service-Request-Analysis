use NYC311_Analysis;
go

select count(*) as TotalRequests from dbo.ServiceRequests;

select Agency,count(*) as TotalRequests  from dbo.ServiceRequests group by Agency order by TotalRequests DESC;

select count(*) as TotalRequests from dbo.ServiceRequests where Agency=  'NYPD';

SELECT
    Problem_formerly_Complaint_Type,
    COUNT(*) AS TotalRequests
FROM dbo.ServiceRequests
WHERE Agency = 'NYPD'
GROUP BY Problem_formerly_Complaint_Type
ORDER BY TotalRequests DESC;


SELECT
    Borough,
    COUNT(*) AS TotalRequests
FROM dbo.ServiceRequests
WHERE Agency = 'NYPD'
GROUP BY Borough
ORDER BY TotalRequests DESC;

SELECT
    Problem_formerly_Complaint_Type,
    COUNT(*) AS TotalRequests
FROM dbo.ServiceRequests
WHERE Agency = 'NYPD'
    AND Borough = 'Bronx'
GROUP BY Problem_formerly_Complaint_Type
ORDER BY TotalRequests DESC;

SELECT
    Agency,
    COUNT(*) AS TotalRequests
FROM dbo.ServiceRequests
GROUP BY Agency
HAVING COUNT(*) > 10000
ORDER BY TotalRequests DESC;

with AgencyRequests as( select Agency,count(*) as TotalRequests from dbo.ServiceRequests  group by Agency)
select * from AgencyRequests where TotalRequests > 10000 order by TotalRequests desc;

WITH BoroughRequests AS (
    select borough ,count(*) as TotalRequests from  dbo.ServiceRequests Group by Borough
)
SELECT *
FROM BoroughRequests
WHERE TotalRequests > 30000
ORDER BY TotalRequests DESC;

SELECT
    Borough,
    COUNT(*) AS TotalRequests,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS BoroughRank
FROM dbo.ServiceRequests
GROUP BY Borough;

SELECT
    Borough,
    COUNT(*) AS TotalRequests,
    ROW_NUMBER() OVER (
        ORDER BY COUNT(*) DESC
    ) AS RowNumber,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS BoroughRank
FROM dbo.ServiceRequests
GROUP BY Borough;

SELECT
    Agency,
    COUNT(*) AS TotalRequests,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS AgencyRank
FROM dbo.ServiceRequests
GROUP BY Agency
ORDER BY TotalRequests DESC;


USE NYC311_Analysis;
GO

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT Unique_Key) AS DistinctRequests,
    SUM(
        CASE
            WHEN Closed_Date IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingClosedDates
FROM dbo.ServiceRequests;
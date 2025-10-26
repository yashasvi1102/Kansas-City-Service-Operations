USE DAMG7370FALL2025;
GO

/* ==========================================================
   (1) SERVICE REQUESTS OVER TIME
   ========================================================== */

-- (1a) Yearly trend (2018–2021)
SELECT 
    YEAR(CAST(creationdate AS date)) AS Year,
    COUNT(*) AS Requests
FROM dbo.servicerequest
WHERE YEAR(CAST(creationdate AS date)) BETWEEN 2018 AND 2021
GROUP BY YEAR(CAST(creationdate AS date))
ORDER BY Year;

-- (1b) Monthly trend (2018–2021)
SELECT 
    FORMAT(CAST(creationdate AS date), 'yyyy-MM') AS YearMonth,
    COUNT(*) AS Requests
FROM dbo.servicerequest
WHERE YEAR(CAST(creationdate AS date)) BETWEEN 2018 AND 2021
GROUP BY FORMAT(CAST(creationdate AS date), 'yyyy-MM')
ORDER BY YearMonth;


/* ==========================================================
   (2) VOLUME OF SERVICE REQUESTS BY SOURCE
   ========================================================== */
SELECT 
    source,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY source
ORDER BY Requests DESC;


/* ==========================================================
   (3) VOLUME OF SERVICE REQUESTS BY DEPARTMENT
   ========================================================== */
SELECT 
    department,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY department
ORDER BY Requests DESC;


/* ==========================================================
   (4) TOP 10 FASTEST RESPONSE TIMES
   Categorized by Category1 & Type
   ========================================================== */
SELECT TOP (10)
    caseid,
    category1,
    type,
    department,
    source,
    creationdate,
    closedate,
    daystoclose
FROM dbo.servicerequest
WHERE closedate IS NOT NULL
ORDER BY daystoclose ASC;


/* ==========================================================
   (5) GEOGRAPHICAL VISUALIZATION (TOP 10 AREAS)
   ========================================================== */

-- (5a) By Street Address
SELECT TOP (10)
    streetaddress,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY streetaddress
ORDER BY Requests DESC;

-- (5b) By Zip Code
SELECT TOP (10)
    zipcode,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY zipcode
ORDER BY Requests DESC;

-- (5c) By Latitude / Longitude
SELECT TOP (10)
    latitude,
    longitude,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY latitude, longitude
ORDER BY Requests DESC;


/* ==========================================================
   (6) DEPARTMENTAL WORKLOAD VS WORKGROUP
   ========================================================== */
SELECT 
    department,
    workgroup,
    COUNT(*) AS Requests
FROM dbo.servicerequest
GROUP BY department, workgroup
ORDER BY department, Requests DESC;


/* ==========================================================
   (7) RESPONSE TIME ANALYSIS PER DEPARTMENT
   ========================================================== */
SELECT 
    department,
    COUNT(*) AS ClosedCount,
    AVG(daystoclose) AS AvgDays,
    MIN(daystoclose) AS MinDays,
    MAX(daystoclose) AS MaxDays
FROM dbo.servicerequest
WHERE daystoclose IS NOT NULL
GROUP BY department
ORDER BY AvgDays DESC;


/* ==========================================================
   (8) SERVICE REQUEST STATUS COMPOSITION (2018–2021)
   ========================================================== */
SELECT 
    YEAR(CAST(creationdate AS date)) AS Year,
    status,
    COUNT(*) AS Requests
FROM dbo.servicerequest
WHERE YEAR(CAST(creationdate AS date)) BETWEEN 2018 AND 2021
GROUP BY YEAR(CAST(creationdate AS date)), status
ORDER BY Year, Requests DESC;


/* ==========================================================
   (9) TIME TO CLOSURE BY CATEGORY1 (TOP 10 LONGEST)
   ========================================================== */
SELECT TOP (10)
    category1,
    COUNT(*) AS ClosedCount,
    AVG(daystoclose) AS AvgDaysToClose
FROM dbo.servicerequest
WHERE daystoclose IS NOT NULL
GROUP BY category1
ORDER BY AvgDaysToClose DESC;


/* ==========================================================
   (10) WORKLOAD VS EFFICIENCY BY DEPARTMENT
   ========================================================== */
SELECT 
    department,
    COUNT(*) AS TotalRequests,
    AVG(daystoclose) AS AvgDaysToClose
FROM dbo.servicerequest
GROUP BY department
ORDER BY TotalRequests DESC;

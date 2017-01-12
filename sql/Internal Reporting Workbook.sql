USE crmhub_mscrm; 

-- Page 2: Revenue by Company Code Last Week 
DECLARE @TodayDayOfWeek INT 
DECLARE @EndOfPrevWeek DATETIME 
DECLARE @StartOfPrevWeek DATETIME 

SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT FSOD.sm_companycode                  AS 'CompanyCode', 
       CONVERT(INT, Sum(FSOD.quantity))     AS 'Total Items', 
       Sum(CONVERT(INT, FSOD.sm_ispackage)) AS 'Packages', 
       Sum(FSOD.extendedamount)             AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND FSO.sm_orderdate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) AND 
                                        CONVERT(VARCHAR, @EndOfPrevWeek + 1, 7) 
GROUP  BY FSOD.sm_companycode 
ORDER  BY FSOD.sm_companycode 

-- Page 2: Revenue by Company Code MTD 
SELECT FSOD.sm_companycode                  AS 'CompanyCode', 
       Year(FSO.sm_orderdate)               AS 'Year', 
       CONVERT(INT, Sum(FSOD.quantity))     AS 'Total Items', 
       Sum(CONVERT(INT, FSOD.sm_ispackage)) AS 'Packages', 
       Sum(FSOD.extendedamount)             AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND Month(FSO.sm_orderdate) = Month(Getdate()) 
       AND Day(FSO.sm_orderdate) <= Day(Getdate()) 
       AND ( Year(FSO.sm_orderdate) = Year(Getdate()) 
              OR Year(FSO.sm_orderdate) = Year(Getdate()) - 1 ) 
GROUP  BY FSOD.sm_companycode, 
          Year(FSO.sm_orderdate) 
ORDER  BY FSOD.sm_companycode, 
          Year(FSO.sm_orderdate) DESC 

-- Page 3: Revenue from API MTD 
SELECT Year(FSO.sm_orderdate)               AS 'Year', 
       --MIN(FSO.sm_orderdate) as 'Orders from',  
       --MAX(FSO.sm_orderdate) as 'to',  
       --  MONTH(FSO.sm_orderdate) as 'Month',  
       CONVERT(INT, Sum(FSOD.quantity))     AS 'Items', 
       Sum(CONVERT(INT, FSOD.sm_ispackage)) AS 'of which Packages', 
       Sum(FSOD.extendedamount)             AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND Month(FSO.sm_orderdate) = Month(Getdate()) 
       AND Day(FSO.sm_orderdate) <= Day(Getdate()) 
       AND ( Year(FSO.sm_orderdate) = Year(Getdate()) 
              OR Year(FSO.sm_orderdate) = Year(Getdate()) - 1 ) 
       AND fso.sm_ordertype IN ( 'LPSE', 'LPWB', 'PAIN', 'LPAS', 
                                 'LPUL', 'DIRECT' ) 
GROUP  BY Year(FSO.sm_orderdate) 
ORDER  BY Year(FSO.sm_orderdate) DESC 

-- Page 4: AFSP Presales by Package MTD 
DECLARE @OrderMonth INT 
DECLARE @OrderYear INT 

SET @OrderMonth = 4 
SET @OrderYear = 2016 

SELECT LEFT(sm_sku, 4)          AS 'Package', 
       Sum(fsod.quantity)       AS 'Packages', 
       Sum(fsod.extendedamount) AS 'Total Revenue' 
FROM   filteredsalesorder AS fso WITH (nolock) 
       INNER JOIN filteredsalesorderdetail AS fsod WITH (nolock) 
               ON fso.salesorderid = fsod.salesorderid 
WHERE  ( fsod.sm_sku LIKE 'AFNE-2016%' 
          OR fsod.sm_sku LIKE 'AFEX-2016%' ) 
       AND Datepart(month, fso.sm_orderdate) = @OrderMonth 
       AND Datepart(year, fso.sm_orderdate) = @OrderYear 
GROUP  BY LEFT(sm_sku, 4) 

-- Page 4: AFSP Presales by Customer Type MTD 
SELECT fso.sm_firstorderforcustomer AS 'New Customer', 
       Sum(fsod.quantity)           AS 'Packages', 
       Sum(fsod.extendedamount)     AS 'Total Revenue' 
FROM   filteredsalesorder fso WITH (nolock) 
       INNER JOIN filteredsalesorderdetail fsod WITH (nolock) 
               ON fso.salesorderid = fsod.salesorderid 
WHERE  ( fsod.sm_sku LIKE 'AFNE-2016%' 
          OR fsod.sm_sku LIKE 'AFEX-2016%' ) 
       AND Datepart(month, fso.sm_orderdate) = @OrderMonth 
       AND Datepart(year, fso.sm_orderdate) = @OrderYear 
GROUP  BY sm_firstorderforcustomer 

-- Page 5: New v Returning Customers Last Week 
SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT fso.sm_firstorderforcustomername AS 'New Customer', 
       Min(FSO.sm_orderdate)            AS 'Orders from', 
       Max(FSO.sm_orderdate)            AS 'to', 
       CONVERT(INT, Sum(FSOD.quantity)) AS 'Items', 
       Sum(FSOD.extendedamount)         AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND FSO.sm_orderdate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) AND 
                                        CONVERT(VARCHAR, @EndOfPrevWeek + 1, 7) 
GROUP  BY FSO.sm_firstorderforcustomername 

-- Page 5: New v Returning Customers MTD 
SELECT fso.sm_firstorderforcustomername AS 'New Customer', 
       Min(FSO.sm_orderdate)            AS 'Orders from', 
       Max(FSO.sm_orderdate)            AS 'to', 
       CONVERT(INT, Sum(FSOD.quantity)) AS 'Items', 
       Sum(FSOD.extendedamount)         AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND Month(FSO.sm_orderdate) = Month(Getdate()) 
       AND Day(FSO.sm_orderdate) <= Day(Getdate()) 
       AND ( Year(FSO.sm_orderdate) = Year(Getdate()) 
              OR Year(FSO.sm_orderdate) = Year(Getdate()) - 1 ) 
GROUP  BY FSO.sm_firstorderforcustomername, 
          Year(FSO.sm_orderdate) 
ORDER  BY FSO.sm_firstorderforcustomername, 
          Year(FSO.sm_orderdate) DESC 

-- Page 6: Top Certificates Last Week 
SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT TOP 3 Min(FC.sm_cpedate)  AS 'Certificates from', 
             Max(FC.sm_cpedate)  AS 'to', 
             FC.sm_courseacronym AS 'Course', 
             Count(FC.sm_email)  AS 'Certificates Issued' 
FROM   filteredsm_certifications AS FC 
WHERE  FC.sm_email NOT LIKE '%cpenow.com' 
       AND FC.sm_cpedate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) AND 
                                     CONVERT(VARCHAR, @EndOfPrevWeek + 1, 7) 
       AND FC.sm_cpetype LIKE '%Self%' 
GROUP  BY FC.sm_courseacronym 
ORDER  BY Count(FC.sm_email) DESC 

-- Page 6: Top Webinar Registrations Last Week 
SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT TOP 3 Min(FWR.sm_registrationdate)             AS 'Registrations from', 
             Max(FWR.sm_registrationdate)             AS 'to', 
             FWR.sm_eventsku                          AS 'SKU', 
             FCV.sm_name                              AS 'Course', 
             Count(FWR.sm_email)                      AS 'Registrants', 
             Sum(CONVERT(INT, FWR.sm_ispackagebased)) AS 'Package Registrants' 
FROM   filteredsm_webinarregistration AS FWR 
       LEFT JOIN filteredsm_courseversion AS FCV 
              ON LEFT(FWR.sm_eventsku, 12) = FCV.sm_version 
WHERE  FWR.sm_email NOT LIKE '%cpenow.com' 
       AND FWR.sm_registrationdate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) 
                                           AND 
                                               CONVERT(VARCHAR, @EndOfPrevWeek + 
                                                                1, 7) 
GROUP  BY FWR.sm_eventsku, 
          FCV.sm_name 
ORDER  BY Count(FWR.sm_email) DESC 

-- Page 6: Top Webinars Last Week 
SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT TOP 3 Min(FSO.sm_orderdate)            AS 'Orders from', 
             Max(FSO.sm_orderdate)            AS 'to', 
             FSOD.sm_sku                      AS 'SKU', 
             FCV.sm_name                      AS 'Course', 
             CONVERT(INT, Sum(FSOD.quantity)) AS 'Items', 
             Sum(FSOD.extendedamount)         AS 'Total Revenue' 
FROM   filteredsalesorder AS FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail AS FSOD WITH (nolock) 
              ON FSO.salesorderid = FSOD.salesorderid 
       LEFT JOIN filteredsm_courseversion AS FCV 
              ON LEFT(FSOD.sm_sku, 12) = FCV.sm_version 
WHERE  FSO.sm_orderemail NOT LIKE '%cpenow.com' 
       AND FSOD.extendedamount <> 0 
       AND FSO.statecodename <> 'Canceled' 
       AND FSO.sm_orderdate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) AND 
                                        CONVERT(VARCHAR, @EndOfPrevWeek + 1, 7) 
       AND fsod.sm_productidname = 'WEBNR' 
       AND fsod.sm_ispackage = 0 
GROUP  BY FSOD.sm_sku, 
          FCV.sm_name 
ORDER  BY Sum(fsod.extendedamount) DESC 

-- Page 7: Top Webinar Registrations Last Year This Time 
SELECT TOP 20 FWR.sm_eventsku     AS 'SKU', 
              FCV.sm_name, 
              Count(FWR.sm_email) AS 'Registrants' 
FROM   filteredsm_webinarregistration AS FWR 
       LEFT JOIN filteredsm_courseversion AS FCV 
              ON LEFT(FWR.sm_eventsku, 12) = FCV.sm_version 
WHERE  FWR.sm_email NOT LIKE '%cpenow.com' 
       AND FWR.sm_registrationdate >= Dateadd(yy, -1, Getdate()) 
       AND FWR.sm_registrationdate <= Dateadd(dd, -335, Getdate()) 
GROUP  BY FWR.sm_eventsku, 
          FCV.sm_name 
ORDER  BY Count(FWR.sm_email) DESC 
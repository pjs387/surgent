USE crmhub_mscrm; 

DECLARE @TodayDayOfWeek INT 
DECLARE @EndOfPrevWeek DATETIME 
DECLARE @StartOfPrevWeek DATETIME 

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
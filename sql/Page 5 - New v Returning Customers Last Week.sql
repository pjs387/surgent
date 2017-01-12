USE crmhub_mscrm; 

DECLARE @TodayDayOfWeek INT 
DECLARE @EndOfPrevWeek DATETIME 
DECLARE @StartOfPrevWeek DATETIME 

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
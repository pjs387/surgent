USE crmhub_mscrm; 

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
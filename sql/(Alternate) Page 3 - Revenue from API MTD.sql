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
       AND MONTH(FSO.sm_orderdate)=4 
       AND ( YEAR(FSO.sm_orderdate)=2016 
              OR YEAR(FSO.sm_orderdate)=2015 ) 
       AND fso.sm_ordertype IN ( 'LPSE', 'LPWB', 'PAIN', 'LPAS', 
                                 'LPUL', 'DIRECT' ) 
GROUP  BY Year(FSO.sm_orderdate) 
ORDER  BY Year(FSO.sm_orderdate) DESC 
USE crmhub_mscrm; 

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
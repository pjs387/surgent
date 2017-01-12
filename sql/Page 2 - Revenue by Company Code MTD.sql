USE crmhub_mscrm; 

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
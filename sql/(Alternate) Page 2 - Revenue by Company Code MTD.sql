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
       AND MONTH(FSO.sm_orderdate)=4 
       AND ( YEAR(FSO.sm_orderdate)=2016 
              OR YEAR(FSO.sm_orderdate)=2015 ) 

GROUP  BY FSOD.sm_companycode, 
          Year(FSO.sm_orderdate) 
ORDER  BY FSOD.sm_companycode, 
          Year(FSO.sm_orderdate) DESC 
USE crmhub_mscrm; 

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
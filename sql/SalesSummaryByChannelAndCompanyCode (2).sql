USE crmhub_mscrm 

go 

DECLARE @StartDate DATETIME 
DECLARE @EndDate DATETIME 

--Adjust these two Variables 
SET @StartDate = '3/1/2016' 
SET @EndDate = '4/1/2016'--always do +1 day from when you want to report on 
SELECT CASE 
         WHEN fso.sm_ordertype NOT IN ( 'WEB', 'MREF', 'FIRM', 'JMS', 
                                           'LWO', 'LSK', 'Direct', 'Cast', 
                                           'DIRECT2', 'TICW', 'SPEC' ) THEN 'API' 
         ELSE fso.sm_ordertype 
       END              AS ordertype, 
       Sum(totalamount) AS 'Order Total', 
       Count(*)         AS '# of Orders', 
       Sum(fso.totaltax), 
       Sum(fso.freightamount) 
FROM   filteredsalesorder FSO WITH (nolock) 
WHERE  fso.sm_orderdate BETWEEN @StartDate AND @EndDate 
       AND fso.statuscodename NOT IN ( 'Canceled' ) 
       AND fso.sm_ordertype NOT IN ( 'SPEC', 'CAST', 'TICW', 'WREF', 'LPSM' ) 
       AND fso.totalamount <> 0 --Remove $0 orders 
       AND fso.sm_orderemail NOT LIKE '%@cpenow.com' 
       AND fso.sm_orderemail NOT LIKE '%@surgent.com' 
       AND fso.sm_orderemail NOT LIKE '%@everestcrm.com' 
GROUP  BY CASE 
            WHEN fso.sm_ordertype NOT IN ( 'WEB', 'MREF', 'FIRM', 'JMS', 
                                           'LWO', 'LSK', 'Direct', 'Cast', 
                                           'DIRECT2', 'TICW', 'SPEC' ) THEN 
            'API' 
            ELSE fso.sm_ordertype 
          END 
ORDER  BY Sum(totalamount) DESC 

SELECT fsod.sm_companycode, 
       CASE 
         WHEN fso.sm_ordertype NOT IN ( 'WEB', 'MREF', 'FIRM', 'JMS', 
                                        'LWO', 'LSK', 'Direct', 'Cast', 
                                        'DIRECT2', 'TICW', 'SPEC' ) THEN 'API' 
         ELSE fso.sm_ordertype 
       END                 AS ordertype, 
       Sum(extendedamount) AS 'Order Total', 
       Count(*)            AS '# of Orders' 
FROM   filteredsalesorder FSO WITH (nolock) 
       LEFT JOIN filteredsalesorderdetail fsod WITH (nolock) 
              ON fso.salesorderid = fsod.salesorderid 
WHERE  fso.sm_orderdate BETWEEN @StartDate AND @EndDate 
       AND fso.statuscodename NOT IN ( 'Canceled' ) 
       AND fso.sm_ordertype NOT IN ( 'SPEC', 'CAST', 'TICW', 'WREF', 'LPSM' ) 
       AND fso.totalamount <> 0 --Remove $0 orders 
       AND fso.sm_orderemail NOT LIKE '%@cpenow.com' 
       AND fso.sm_orderemail NOT LIKE '%@surgent.com' 
       AND fso.sm_orderemail NOT LIKE '%@everestcrm.com' 
GROUP  BY CASE 
            WHEN fso.sm_ordertype NOT IN ( 'WEB', 'MREF', 'FIRM', 'JMS', 
                                           'LWO', 'LSK', 'Direct', 'Cast', 
                                           'DIRECT2', 'TICW', 'SPEC' ) THEN 
            'API' 
            ELSE fso.sm_ordertype 
          END, 
          fsod.sm_companycode 
ORDER  BY fsod.sm_companycode, 
          Sum(extendedamount) DESC 
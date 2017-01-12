USE crmhub_mscrm 

SELECT o.NAME                                   AS 'Order Name', 
       d.sm_shippeddate                         AS 'Shipped Date', 
       Year(d.sm_shippeddate)                   AS 'Shipped Date Year', 
       Month(d.sm_shippeddate)                  AS 'Shipped Date Month', 
       o.sm_orderdate                           AS 'Order Date', 
       CASE 
         WHEN a.sm_sponsortypename = 'ST Society' THEN a.NAME 
         ELSE 'N/A' 
       END                                      'Account(Order)', 
       o.statecodename                          AS 'Order Status', 
       o.statuscodename                         AS 'Status Reason', 
       d.productdescription                     AS 'Write-in Product', 
       d.priceperunit                           AS 'Price Per Unit', 
       d.quantity                               AS 'Quantity', 
       d.extendedamount                         AS 'Extended Amount', 
       d.sm_companycode, 
       CASE 
         WHEN o.sm_statesociety IS NULL THEN 'N/A' 
         WHEN o.sm_statesociety IN ( '_na', 'None' ) THEN 'N/A' 
         ELSE o.sm_statesociety 
       END                                      'State Society Self Identified', 
       d.sm_ispackagename                       AS 'Is Package?', 
       d.sm_commissionamount                    AS 'Commission Amount', 
       d.sm_commission, 
       Isnull(COALESCE(d.sm_commissionprogramidname, 
              d.sm_commissionproductidname, 
                     d.sm_commissionpackageidname, 
       d.sm_commissionproductcourseidname), '') AS 'Commission Plan', 
       o.sm_ordertype                           AS 'Order Type', 
       CASE 
         WHEN ar.sm_sponsortypename = 'ST Society' THEN 'Referred' 
         ELSE 'Self-Identified' 
       END                                      AS 'Referrer Code', 
       o.sm_firstorderforcustomername           AS 'First Order?' 
FROM   filteredsalesorder AS o 
       INNER JOIN filteredsalesorderdetail AS d 
               ON o.salesorderid = d.salesorderid 
       LEFT JOIN filteredaccount AS a 
              ON o.sm_accountid = a.accountid 
       -- Join to get the associated account 
       LEFT JOIN filteredaccount AS ar 
              ON ar.accountid = o.sm_referrercode 
--Join to get the referrer account(could be different than order associated account) 
WHERE  d.extendedamount <> 0 
       AND o.sm_ordertype <> 'WREF' 
       AND o.statecodename <> 'Canceled' 
       AND d.sm_shippeddate >= '2013-01-01' 
       AND d.sm_shippeddate < '2016-1-1' 
       AND sm_orderemail NOT LIKE '%@cpenow.com' 
       AND sm_orderemail NOT LIKE '%@surgent.com' 
ORDER  BY o.sm_orderdate DESC
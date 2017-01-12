USE CRMHUB_MSCRM
GO

DECLARE @SearchYear varchar(4)
SET @SearchYear = '2016'

--UNLM Totals by Month
SELECT DISTINCT 
 MONTH(FSOD.sm_shippeddate) as ShipMonth,
 fso.salesorderid,
 fso.name,
 fsod.sm_sku,
 fsod.extendedamount,
 fso.sm_orderemail,
 fsod.sm_shippeddate,
 FSOD.extendedamount as SalesTotal,
 FSOD.quantity as Quantity
FROM 
	FilteredSalesOrderDetail FSOD with (NOLOCK)
INNER JOIN 
	FilteredSalesOrder FSO with (NOLOCK) ON FSOD.salesorderid = FSO.salesorderid
WHERE 
	FSO.statecodename = 'Active'
	AND FSO.statuscode NOT IN (930860001) --('Canceled')
	AND LEFT(RTRIM(LTRIM(FSOD.SM_SKU)),4) in ('UNLM','UNPW','UNSW')
	and SUBSTRING(RTRIM(LTRIM(FSOD.SM_SKU)),LEN(RTRIM(LTRIM(FSOD.SM_SKU)))-LEN('XXX-01-WEBNR'),4) = @SearchYear
	AND fsod.extendedamount <> 0
	AND fso.sm_orderemail NOT LIKE '%@cpenow.com'
	and MONTH(FSOD.sm_shippeddate) = 1
order by fso.salesorderid

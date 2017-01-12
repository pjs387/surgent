/*********************************************************************
* UNLM Package Sales By Month Summary
* Description: Provide summary total revenue and # of orders for UNLM Package
* for the year
* Created By: Matt Bricker
* Create Date: 10/20/2015
**********************************************************************/
USE CRMHUB_MSCRM
GO

DECLARE @SearchYear varchar(4)
SET @SearchYear = '2016'

--UNLM Totals by Month
SELECT DISTINCT 
 MONTH(FSOD.sm_shippeddate) as ShipMonth,
 SUM(FSOD.extendedamount) as SalesTotal,
 CONVERT(int,SUM(FSOD.quantity)) as Quantity
FROM 
	FilteredSalesOrderDetail FSOD with (NOLOCK)
INNER JOIN 
	FilteredSalesOrder FSO with (NOLOCK) ON FSOD.salesorderid = FSO.salesorderid
LEFT JOIN 
	FilteredContact C with (NOLOCK) ON FSO.customerid = C.CONTACTID
WHERE 
	FSO.statecodename = 'Active'
	AND FSO.statuscode NOT IN (930860001) --('Canceled')
	AND LEFT(RTRIM(LTRIM(FSOD.SM_SKU)),4) in ('UNLM','UNPW','UNSW')
	and SUBSTRING(RTRIM(LTRIM(FSOD.SM_SKU)),LEN(RTRIM(LTRIM(FSOD.SM_SKU)))-LEN('XXX-01-WEBNR'),4) = @SearchYear
	AND fsod.extendedamount <> 0
	AND C.emailaddress1 NOT LIKE '%@cpenow.com'
group by 
	MONTH(FSOD.sm_shippeddate)
order by 
	MONTH(FSOD.sm_shippeddate)


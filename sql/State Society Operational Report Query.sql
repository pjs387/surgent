use CRMHUB_MSCRM

SELECT 
	o.name AS 'Order Name', 
	d.sm_shippeddate AS 'Shipped Date', 
	year(d.sm_shippeddate) AS 'Shipped Date Year', 
	month(d.sm_shippeddate) AS 'Shipped Date Month', 
	o.sm_orderdate as 'Order Date',
	year(o.sm_orderdate) AS 'Order Date Year', 
	month(o.sm_orderdate) AS 'Order Date Month', 
	CASE 
		WHEN a.sm_sponsortypename = 'ST Society' THEN
			a.name
		WHEN asi.sm_sponsortypename = 'ST Society' THEN
			asi.name
		ELSE 
			'N/A'
	END 'Account(Order)',
	--o.statecodename AS 'Order Status', 
	--o.statuscodename AS 'Status Reason',
	d.productdescription as 'Write-in Product',
	d.priceperunit AS 'Price Per Unit', 
	d.quantity AS 'Quantity', 
	d.extendedamount AS 'Extended Amount',
	d.sm_companycode as 'Company Code',
	CASE 
		WHEN 
			o.sm_statesociety is null THEN 'N/A'
		WHEN 
			o.sm_statesociety in ('_na', 'None') THEN 'N/A'
		ELSE
			o.sm_statesociety
	END 'State Society Self Identified',
	d.sm_ispackagename AS 'Is Package?',
	ISNULL(d.sm_commissionamount,0.00) AS 'Commission Amount',
	isnull(d.sm_commission,0) as 'Commission %',
	--isnull(coalesce(d.sm_commissionprogramidname, d.sm_commissionproductidname, d.sm_commissionpackageidname, d.sm_commissionproductcourseidname),'') as 'Commission Plan',
	o.sm_ordertype AS 'Order Type',
	CASE
		WHEN 
			o.sm_ordertype not in ('WEB', 'MREF', 'FIRM', 'JMS', 'LWO', 'LSK', 'Direct', 'Cast', 'DIRECT2', 'TICW', 'SPEC') THEN 'API'
		WHEN 
			ar.sm_sponsortypename = 'ST Society' THEN 'Referred'
		ELSE 
			'Self-Identified'
	END AS 'Source' ,
	o.sm_firstorderforcustomername as 'First Order?'
FROM 
	FilteredSalesOrder AS o
INNER JOIN 
	FilteredSalesOrderDetail AS d ON o.salesorderid = d.salesorderid
LEFT JOIN 
	FilteredAccount AS a ON o.sm_accountid = a.accountid -- Join to get the associated account
LEFT JOIN 
	FilteredAccount as ar on ar.accountid = o.sm_referrercode--Join to get the referrer account(could be different than order associated account)
LEFT JOIN 
	FilteredAccount as asi on asi.sm_sponsorid = o.sm_statesociety --join to get the self-identified state society
WHERE 
	o.totalamount <> 0 
	AND o.sm_ordertype <> 'WREF' 
	AND o.statecodename <> 'Canceled' 
	AND o.sm_orderdate >= '2013-01-01'
	AND sm_orderemail not like '%@cpenow.com'
	AND sm_orderemail not like '%@surgent.com'
	AND sm_orderemail not like '%@everestcrm.com'
order by o.sm_orderdate desc
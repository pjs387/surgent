-- Beast Mode Calculations

-- Today
CASE 
WHEN MONTH(`Order Date (Cash)`) = MONTH(CURRENT_DATE())
AND DAYOFMONTH(`Order Date (Cash)`) = DAYOFMONTH(CURRENT_DATE())
THEN 'YES'
ELSE 'NO'
END
-- Yesterday
CASE 
WHEN MONTH(`Order Date (RevRec)`) = MONTH(CURRENT_DATE())
AND DAYOFMONTH(`Order Date (RevRec)`) = (DAYOFMONTH(CURRENT_DATE()) - 1)
THEN 'YES'
ELSE 'NO'
END
-- This Week
CASE 
WHEN WEEKOFYEAR(`Order Date`) = WEEKOFYEAR(CURRENT_DATE())
THEN 'YES'
ELSE 'NO'
END
-- Last Week
CASE 
WHEN WEEKOFYEAR(`Order Date`) = (WEEKOFYEAR(CURRENT_DATE()) - 1)
THEN 'YES'
ELSE 'NO'
END

-- MTD
CASE 
WHEN MONTH(`Order Date`) = MONTH(CURRENT_DATE())
AND DAYOFMONTH(`Order Date`) < DAYOFMONTH(CURRENT_DATE())
THEN 'YES'
ELSE 'NO'
END
-- YTD
CASE 
WHEN DAYOFYEAR(`Order Date (RevRec)`) < DAYOFYEAR(CURRENT_DATE())
THEN 'YES'
ELSE 'NO'
END
-- YTD
CASE 
WHEN DAYOFYEAR(`Order Date (Cash)`) < DAYOFYEAR(CURRENT_DATE())
THEN 'YES'
ELSE 'NO'
END
-- Transactions
Count(Distinct(`Sales Order ID`))
-- Net Revenue Diff - PPC Performance
SUM(`Net Revenue`) - SUM(`Net Revenue (Last Week)`)
-- Net Revenue Diff % - PPC Performance
(SUM(`Net Revenue`) - SUM(`Net Revenue (Last Week)`)) / SUM(`Net Revenue (Last Week)`)
-- Impressions Diff - PPC Performance
SUM(`Impressions`) - SUM(`Impressions (Last Week)`)
-- Impressions Diff % - PPC Performance
(SUM(`Impressions`) - SUM(`Impressions (Last Week)`)) / SUM(`Impressions (Last Week)`)
-- Conversions Diff - PPC Performance
SUM(`Conversions`) - SUM(`Conversions (Last Week)`)
-- Conversions Diff % - PPC Performance
(SUM(`Conversions`) - SUM(`Conversions (Last Week)`)) / SUM(`Conversions (Last Week)`)
-- CTR Diff - PPC Performance
SUM(`CTR`) - SUM(`CTR (Last Week)`)
-- CTR Diff % - PPC Performance
(SUM(`CTR`) - SUM(`CTR (Last Week)`)) / SUM(`CTR (Last Week)`)
-- Conversion Rate (Session)
SUM(`Transactions`)/SUM(`Sessions`)
-- Average Order Value
SUM(`Revenue`) / SUM(`Transactions`)
-- Return On Ad Spend
SUM(`Conversion Value`) / SUM(`Cost`)
-- Return on Investment
SUM(`Net Revenue`) / SUM(`Cost`)
-- Conversion Rate
SUM(`Conversions`) / SUM(`Clicks`)
-- Cost Per Click (CPC)
SUM(`Cost`) / SUM(`Clicks`)
-- Click Through Rate (CTR)
SUM (`Clicks`) / SUM (`Impressions`)
-- Conversion Cost
SUM (`Cost`) / SUM (`Conversions`)
-- Average Order Value (AOV)
SUM(`Net Revenue`) / SUM(`Conversions`)
-- Average Order Value (AOV)
SUM(`Revenue`) / COUNT(DISTINCT `Order Name`)
-- Average Units per Order
SUM(`Quantity`) / COUNT(DISTINCT `Order Name`)
-- Average Units per Order
SUM(`Revenue`) / SUM(`Quantity`)
-- Average Registrations per Unique User
COUNT(`Registration ID`) / COUNT(DISTINCT `Registrant Email`)
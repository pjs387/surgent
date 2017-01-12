/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	tempattendeeemail,
	case when packagesnorid is null then 1
	else 0 end as 'PackageUser'
  FROM 
	[AllStarTax].[dbo].[su_EventResgistration2] e
  where
	tempattendeeemail not like '%@surgent.com' and tempattendeeemail not like '%@cpenow.com'
	and validated is not null
  group by tempattendeeemail,packagesnorid
  order by tempattendeeemail


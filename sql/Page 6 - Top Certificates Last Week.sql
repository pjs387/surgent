USE crmhub_mscrm; 

DECLARE @TodayDayOfWeek INT 
DECLARE @EndOfPrevWeek DATETIME 
DECLARE @StartOfPrevWeek DATETIME 

SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT TOP 3 Min(FC.sm_cpedate)  AS 'Certificates from', 
             Max(FC.sm_cpedate)  AS 'to', 
             FC.sm_courseacronym AS 'Course', 
             Count(FC.sm_email)  AS 'Certificates Issued' 
FROM   filteredsm_certifications AS FC 
WHERE  FC.sm_email NOT LIKE '%cpenow.com' 
       AND FC.sm_cpedate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) AND 
                                     CONVERT(VARCHAR, @EndOfPrevWeek + 1, 7) 
       AND FC.sm_cpetype LIKE '%Self%' 
GROUP  BY FC.sm_courseacronym 
ORDER  BY Count(FC.sm_email) DESC 
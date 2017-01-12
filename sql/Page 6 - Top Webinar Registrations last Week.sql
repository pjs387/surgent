USE crmhub_mscrm; 

DECLARE @TodayDayOfWeek INT 
DECLARE @EndOfPrevWeek DATETIME 
DECLARE @StartOfPrevWeek DATETIME 

SET @TodayDayOfWeek = Datepart(dw, Getdate()) 
SET @EndOfPrevWeek = Dateadd(dd, -@TodayDayOfWeek, Getdate()) 
SET @StartOfPrevWeek = Dateadd(dd, -( @TodayDayOfWeek + 6 ), Getdate()) 

SELECT TOP 3 Min(FWR.sm_registrationdate)             AS 'Registrations from', 
             Max(FWR.sm_registrationdate)             AS 'to', 
             FWR.sm_eventsku                          AS 'SKU', 
             FCV.sm_name                              AS 'Course', 
             Count(FWR.sm_email)                      AS 'Registrants', 
             Sum(CONVERT(INT, FWR.sm_ispackagebased)) AS 'Package Registrants' 
FROM   filteredsm_webinarregistration AS FWR 
       LEFT JOIN filteredsm_courseversion AS FCV 
              ON LEFT(FWR.sm_eventsku, 12) = FCV.sm_version 
WHERE  FWR.sm_email NOT LIKE '%cpenow.com' 
       AND FWR.sm_registrationdate BETWEEN CONVERT(VARCHAR, @StartOfPrevWeek, 7) 
                                           AND 
                                               CONVERT(VARCHAR, @EndOfPrevWeek + 
                                                                1, 7) 
GROUP  BY FWR.sm_eventsku, 
          FCV.sm_name 
ORDER  BY Count(FWR.sm_email) DESC 
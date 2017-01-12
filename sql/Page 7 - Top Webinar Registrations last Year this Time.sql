USE crmhub_mscrm; 

SELECT TOP 20 FWR.sm_eventsku     AS 'SKU', 
              FCV.sm_name, 
              Count(FWR.sm_email) AS 'Registrants' 
FROM   filteredsm_webinarregistration AS FWR 
       LEFT JOIN filteredsm_courseversion AS FCV 
              ON LEFT(FWR.sm_eventsku, 12) = FCV.sm_version 
WHERE  FWR.sm_email NOT LIKE '%cpenow.com' 
       AND FWR.sm_registrationdate >= Dateadd(yy, -1, Getdate()) 
       AND FWR.sm_registrationdate <= Dateadd(dd, -335, Getdate()) 
GROUP  BY FWR.sm_eventsku, 
          FCV.sm_name 
ORDER  BY Count(FWR.sm_email) DESC 
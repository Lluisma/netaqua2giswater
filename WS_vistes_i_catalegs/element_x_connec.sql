
CREATE OR REPLACE VIEW ELEMENT_X_CONNEC AS

  SELECT ROWNUM id, element_id, connec_id 
  FROM (
            
    -- FONT / ABEURADOR : AIXETA

    SELECT  'AIX_1_' || T1.ID_FONT  element_id,
            CASE
              WHEN T1.TIPUS='AG' THEN '1_ABEURADOR_' || T1.ID_FONT
              ELSE '1_FONT_' || T1.ID_FONT 
            END                     connec_id
    FROM    NA_MATARO.NA_V_FONT T1
    WHERE   AIXETA IS NOT NULL OR AIX_ROSC IS NOT NULL OR AIX_NUME IS NOT NULL
    
    -- FONT / ABEURADOR  : ARQFONT
    
    UNION
      
    SELECT  'ARF_1_' || T1.ID_FONT  element_id,
            CASE
              WHEN T1.TIPUS='AG' THEN '1_ABEURADOR_' || T1.ID_FONT
              ELSE '1_FONT_' || T1.ID_FONT 
            END                
    FROM    NA_MATARO.NA_V_FONT T1
    WHERE   ARQ_SECC IS NOT NULL OR ARQ_MATE IS NOT NULL OR ARQ_SECC IS NOT NULL OR ARQ_DIAM IS NOT NULL
    
    -- ESCO : PORTELLA
    
    UNION
    
    SELECT  'POR1_1_' || T1.ID_ESCO  element_id,
            '1_ESCOMESA_' || T1.ID_ESCO  connec_id
    FROM NA_MATARO.NA_V_ESCO T1
    WHERE T1.MAT1 IS NOT NULL OR T1.MID1 IS NOT NULL OR T1.SIT1 IS NOT NULL
    UNION
    SELECT  'POR2_1_' || T1.ID_ESCO   element_id,
            '1_ESCOMESA_' || T1.ID_ESCO  connec_id
    FROM NA_MATARO.NA_V_ESCO T1
    WHERE T1.MAT2 IS NOT NULL OR T1.MID2 IS NOT NULL OR T1.SIT2 IS NOT NULL
    UNION    
    SELECT  'POR3_1_' || T1.ID_ESCO  element_id,
            '1_ESCOMESA_' || T1.ID_ESCO  connec_id
    FROM NA_MATARO.NA_V_ESCO T1
    WHERE T1.MAT3 IS NOT NULL OR T1.MID3 IS NOT NULL OR T1.SIT3 IS NOT NULL
  
  );
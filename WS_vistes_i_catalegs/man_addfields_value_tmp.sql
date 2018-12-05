

CREATE OR REPLACE VIEW MAN_ADDFIELDS_VALUE_TMP AS

	SELECT	ROWNUM	id, 
          TA.feature_id,
          TA.parameter_id,
          CASE
            WHEN SUBSTR(TA.value_param,1,1) = '.' THEN '0' || TA.value_param
            ELSE TA.value_param
          END value_param,
          TA.expl_id,
          TA.featurecat_id,
          TA.id_amsa
	FROM (

		SELECT	ID_FONT   					 			feature_id,
		        1         								parameter_id,
		      	CONTINU 							  	value_param,
		      	1										      expl_id,
            CASE TIPUS
              WHEN 'AG' THEN 'ABEURADOR'
		      	  ELSE 'FONT'
            END                       featurecat_id,
		      	ID_FONT									  id_amsa
		FROM 	NA_MATARO.NA_V_FONT
    WHERE CONTINU IS NOT NULL

    UNION
    
    SELECT	ID_FONT, 
            2, 
            CASE ARQ2_VALV
              WHEN 'B' THEN 'VALV_B_XX'
              WHEN 'C' THEN 'VALV_C-XX'
              ELSE 'VALV_XX'
            END,  
            1,
            CASE TIPUS
              WHEN 'AG' THEN 'ABEURADOR'
		      	  ELSE 'FONT'
            END,                       
            ID_FONT  
    FROM    NA_MATARO.NA_V_FONT  
    WHERE   ARQ2_VALV <> 'NO'
    
    UNION
    
    SELECT	ID_FONT, 
            3, 
            CAST(ARQ_DIST AS VARCHAR(10)), 
            1, 
            CASE TIPUS
              WHEN 'AG' THEN 'ABEURADOR'
		      	  ELSE 'FONT'
            END,
            ID_FONT  
    FROM    NA_MATARO.NA_V_FONT  
    WHERE   ARQ_DIST IS NOT NULL AND ARQ_DIST > 0
        
		UNION

		SELECT	ID_PCAR, 4, CAST(DIAMETRE_RACOR AS VARCHAR(10)), 1, 'PUNT_CAR', ID_PCAR  FROM  NA_MATARO.NA_V_PCAR  WHERE DIAMETRE_RACOR IS NOT NULL

		UNION

		SELECT	T1.ID_TRAM, 5, T1.GRUP, 1, 'PIPE', T1.ID_TRAM  
    FROM    NA_MATARO.NA_V_TRAM T1
              LEFT JOIN NA_MATARO.CAT_T_SUBXARXA T2 ON T1.ID_SUBXARXA = T2.ID_SUBXARXA
    WHERE   T1.GRUP IS NOT NULL
      AND   T2.CATEGORIA <> 'T'

		UNION

		SELECT	ID_TRAM, 6, 
            CASE RETI_FIBROCIMENT
              WHEN 'SI' THEN 'true'
              ELSE 'false'
            END, 1, 'PIPE', ID_TRAM  FROM  NA_MATARO.NA_V_TRAM  WHERE RETI_FIBROCIMENT IS NOT NULL

		UNION

		SELECT	ID_DIPO, 7, CAST(NIVELL_INI AS VARCHAR(10)), 1, 'DIPOSIT', ID_DIPO  FROM  NA_MATARO.NA_V_DIPO  WHERE NIVELL_INI IS NOT NULL AND NIVELL_INI > 0

		UNION

		SELECT	ID_DIPO, 8, CAST(NIVELL_MIN AS VARCHAR(10)), 1, 'DIPOSIT', ID_DIPO  FROM  NA_MATARO.NA_V_DIPO  WHERE NIVELL_MIN IS NOT NULL AND NIVELL_MIN > 0

		UNION

		SELECT	ID_DIPO, 9, CAST(NIVELL_MAX AS VARCHAR(10)), 1, 'DIPOSIT', ID_DIPO  FROM  NA_MATARO.NA_V_DIPO  WHERE NIVELL_MAX IS NOT NULL AND NIVELL_MAX > 0

		UNION

		SELECT	ID_DIPO, 10, CAST(DIAMETRE AS VARCHAR(10)), 1, 'DIPOSIT', ID_DIPO  FROM  NA_MATARO.NA_V_DIPO  WHERE DIAMETRE IS NOT NULL AND DIAMETRE > 0

		UNION

		SELECT	ID_VALV, 11, CAST(DINAMICA AS VARCHAR(10)), 1, 'VREGULADORA', ID_VALV  FROM  NA_MATARO.NA_V_VALV  WHERE DINAMICA IS NOT NULL AND DINAMICA > 0			

		UNION

		SELECT	ID_VALV, 12, 
            CASE FILTRE
              WHEN 'SI' THEN 'true'
              ELSE 'false'
            END, 1, 'VREGULADORA', ID_VALV  FROM  NA_MATARO.NA_V_VALV  WHERE FILTRE IS NOT NULL 


	) TA
	ORDER BY TA.parameter_id, TA.feature_id;
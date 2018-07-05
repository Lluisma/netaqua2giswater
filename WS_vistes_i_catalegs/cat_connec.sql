

CREATE OR REPLACE VIEW TMP_CAT_CONNEC_WJOIN AS

  SELECT DISTINCT
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE   
         END                                 "id",       
         'ESCOMESA'                          CONNECTYPE_ID,
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'XX'
           ELSE T1.MATERIAL
         END                                 MATCAT_ID,
    	 CASE
      	   WHEN INSTR(T2.ESCO_MAT,'PN') = 0
      	   THEN NULL
      	   ELSE TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,'PN')+2)) || ' atm'
    	 END 								PNOM,
         CASE
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.DIAMETRE IS NULL THEN NULL
           ELSE TO_CHAR(T1.DIAMETRE)
         END                                 DNOM,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DINT IS NOT NULL THEN T3.DINT
           WHEN T4.TIPUS='N' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DINT,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DEXT IS NOT NULL THEN T3.DEXT
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DEXT,
         CASE
           WHEN T1.DIAMETRE=0 THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           WHEN T1.DIAMETRE IS NULL THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           ELSE 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø' || T1.DIAMETRE ||' mm'   
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_MATARO.NA_V_ESCO T1
           LEFT JOIN NA_MATARO.CAT2_T_ESCO_MATERIAL T2 ON T1.MATERIAL = T2.ID_ESCO_MAT
           LEFT JOIN CAT_ARC T3 ON T1.MATERIAL || '_' || T1.DIAMETRE = T3."id"
           LEFT JOIN NA_MATARO.CAT_T_MATERIAL T4 ON T1.MATERIAL = T4.ID_MATERIAL
  WHERE  ID_ESCO <> -1
     AND (T1.MATERIAL IS NOT NULL OR T1.DIAMETRE IS NOT NULL)
  UNION
  SELECT DISTINCT
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE    
         END                                 "id",       
         'ESCOMESA'                          CONNECTYPE_ID,
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'XX'
           ELSE T1.MATERIAL
         END                                 MATCAT_ID,
    	 CASE
      	   WHEN INSTR(T2.ESCO_MAT,'PN') = 0
      	   THEN NULL
      	   ELSE TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,'PN')+2)) || ' atm'
    	 END 								 PNOM,
         CASE
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.DIAMETRE IS NULL THEN NULL
           ELSE TO_CHAR(T1.DIAMETRE)
         END                                 DNOM,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DINT IS NOT NULL THEN T3.DINT
           WHEN T4.TIPUS='N' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DINT,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DEXT IS NOT NULL THEN T3.DEXT
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DEXT,
         CASE
           WHEN T1.DIAMETRE=0 THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           WHEN T1.DIAMETRE IS NULL THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           ELSE 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø' || T1.DIAMETRE ||' mm'   
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_FIGARO.NA_V_ESCO T1
           LEFT JOIN NA_FIGARO.CAT2_T_ESCO_MATERIAL T2 ON T1.MATERIAL = T2.ID_ESCO_MAT
           LEFT JOIN CAT_ARC T3 ON T1.MATERIAL || '_' || T1.DIAMETRE = T3."id"
           LEFT JOIN NA_FIGARO.CAT_T_MATERIAL T4 ON T1.MATERIAL = T4.ID_MATERIAL
  WHERE  (T1.MATERIAL IS NOT NULL OR T1.DIAMETRE IS NOT NULL)
  UNION
  SELECT DISTINCT
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE   
         END                                 "id",       
         'ESCOMESA'                          CONNECTYPE_ID,
         CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'XX'
           ELSE T1.MATERIAL
         END                                 MATCAT_ID,
    	 CASE
      	   WHEN INSTR(T2.ESCO_MAT,'PN') = 0
      	   THEN NULL
      	   ELSE TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,'PN')+2)) || ' atm'
    	 END 								 PNOM,
         CASE
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.DIAMETRE IS NULL THEN NULL
           ELSE TO_CHAR(T1.DIAMETRE)
         END                                 DNOM,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DINT IS NOT NULL THEN T3.DINT
           WHEN T4.TIPUS='N' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DINT,
         CASE 
           WHEN T1.DIAMETRE=0 THEN NULL
           WHEN T1.MATERIAL='DE' THEN T1.DIAMETRE
           WHEN T3.DEXT IS NOT NULL THEN T3.DEXT
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE
           ELSE NULL
         END                                 DEXT,
         CASE
           WHEN T1.DIAMETRE=0 THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           WHEN T1.DIAMETRE IS NULL THEN 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø desconegut'
           ELSE 'Escomesa : ' || TRIM(SUBSTR(T2.ESCO_MAT, INSTR(T2.ESCO_MAT,' - ')+3)) || ' - Ø' || T1.DIAMETRE ||' mm'   
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_LLISSADEVALL.NA_V_ESCO T1
           LEFT JOIN NA_LLISSADEVALL.CAT2_T_ESCO_MATERIAL T2 ON T1.MATERIAL = T2.ID_ESCO_MAT
           LEFT JOIN CAT_ARC T3 ON T1.MATERIAL || '_' || T1.DIAMETRE = T3."id"
           LEFT JOIN NA_LLISSADEVALL.CAT_T_MATERIAL T4 ON T1.MATERIAL = T4.ID_MATERIAL
  WHERE  (T1.MATERIAL IS NOT NULL OR T1.DIAMETRE IS NOT NULL)
  ORDER BY "id", DINT, DEXT;


CREATE OR REPLACE VIEW TMP_CAT_CONNEC_TAP AS

  SELECT DISTINCT
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'FONT_XX'
           WHEN T1.TIPUS='AG' THEN 'ABEU_XX'
           ELSE REPLACE(REPLACE(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3), ' '),'À','A')
         END                                 "id",
         CASE
           WHEN T1.TIPUS='AG' THEN 'ABEURADOR'
           ELSE 'FONT'
         END                                 CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         null                                DNOM,
         null                                DINT,
         null                                DEXT,
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'Font Desconeguda'
           WHEN T1.TIPUS='AG' THEN 'Abeurador'
           ELSE 'Font : ' || INITCAP(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3)))
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         REPLACE(UPPER(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3))),' ','_')  "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_MATARO.NA_V_FONT T1
           LEFT JOIN NA_MATARO.CAT2_T_FONT_TIPUS T2 ON T1.TIPUS = T2.ID_FONT_TIPUS
  WHERE  (T1.TIPUS <> 'AL' AND T1.TIPUS <> 'MO') OR T1.TIPUS IS NULL

  UNION
  
  SELECT DISTINCT
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'FONT_XX'
           WHEN T1.TIPUS='AG' THEN 'ABEU_XX'
           ELSE REPLACE(REPLACE(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3), ' '),'À','A')
         END                                 "id",
         CASE
           WHEN T1.TIPUS='AG' THEN 'ABEURADOR'
           ELSE 'FONT'
         END                                 CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         null                                DNOM,
         null                                DINT,
         null                                DEXT,
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'Font Desconeguda'
           WHEN T1.TIPUS='AG' THEN 'Abeurador'
           ELSE 'Font : ' || INITCAP(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3)))
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         REPLACE(UPPER(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3))),' ','_')  "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_FIGARO.NA_V_FONT T1
           LEFT JOIN NA_FIGARO.CAT2_T_FONT_TIPUS T2 ON T1.TIPUS = T2.ID_FONT_TIPUS
  WHERE  (T1.TIPUS <> 'AL' AND T1.TIPUS <> 'MO') OR T1.TIPUS IS NULL

  UNION
  
  SELECT DISTINCT
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'FONT_XX'
           WHEN T1.TIPUS='AG' THEN 'ABEU_XX'
           ELSE REPLACE(REPLACE(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3), ' '),'À','A')
         END                                 "id",
         CASE
           WHEN T1.TIPUS='AG' THEN 'ABEURADOR'
           ELSE 'FONT'
         END                                 CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         null                                DNOM,
         null                                DINT,
         null                                DEXT,
         CASE
           WHEN T2.FONT_TIPUS IS NULL THEN 'Font Desconeguda'
           WHEN T1.TIPUS='AG' THEN 'Abeurador'
           ELSE 'Font : ' || INITCAP(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3)))
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         REPLACE(UPPER(TRIM(SUBSTR(T2.FONT_TIPUS, INSTR(T2.FONT_TIPUS,' - ')+3))),' ','_')  "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_LLISSADEVALL.NA_V_FONT T1
           LEFT JOIN NA_LLISSADEVALL.CAT2_T_FONT_TIPUS T2 ON T1.TIPUS = T2.ID_FONT_TIPUS
  WHERE  (T1.TIPUS <> 'AL' AND T1.TIPUS <> 'MO') OR T1.TIPUS IS NULL

  UNION  
  
  SELECT CASE
           WHEN T1.ID_FONT_TIPUS='AG' THEN 'ABEU_XX'
           ELSE REPLACE(REPLACE(SUBSTR(FONT_TIPUS, INSTR(FONT_TIPUS,' - ')+3), ' '),'À','A')  
         END                                 "id",       
         CASE
           WHEN T1.ID_FONT_TIPUS='AG' THEN 'ABEURADOR'
           ELSE 'FONT'
         END                                 CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         null                                DNOM,
         null                                DINT,
         null                                DEXT,
         CASE
           WHEN T1.ID_FONT_TIPUS='AG' THEN 'Abeurador'
           ELSE 'Font : ' || INITCAP(TRIM(SUBSTR(FONT_TIPUS, INSTR(FONT_TIPUS,' - ')+3)))
         END                                 DESCRIPT,
         null                                "link",
         null                                BRAND,
         REPLACE(UPPER(TRIM(SUBSTR(FONT_TIPUS, INSTR(FONT_TIPUS,' - ')+3))),' ','_')  "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_MATARO.CAT2_T_FONT_TIPUS T1
  WHERE  (T1.ID_FONT_TIPUS <> 'AL' AND T1.ID_FONT_TIPUS <> 'MO')
  ORDER BY "id", DINT, DEXT;


CREATE OR REPLACE VIEW TMP_CAT_CONNEC_GREENTAP AS

  SELECT DISTINCT
         CASE 
           WHEN (T1.TIPUS = 'XX' AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL)) THEN 'BREG_XX'
           WHEN (T1.TIPUS = 'XX') THEN 'BREG_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.TIPUS || '_XX'
           ELSE T1.TIPUS || '_' || T1.DIAMETRE
         END                                 "id",
         'BOCA_REG'                          CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         CASE
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN TO_CHAR(T1.DIAMETRE)
           ELSE null
         END                                 DNOM,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN T1.DIAMETRE
           ELSE null
         END                                 DINT,
         null                                DEXT,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø' || T1.DIAMETRE || ' mm'  
           ELSE 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø desconegut'  
         END                                 DESCRIPT,
         null                                "link",
         T2.BOCAREG_TIPUS_MARCA              BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_MATARO.NA_V_BREG T1
           LEFT JOIN NA_MATARO.CAT2_T_BREG_TIPUS T2 ON T1.TIPUS = T2.ID_BREG_TIPUS
  WHERE  T1.TIPUS IS NOT NULL
  UNION
  SELECT DISTINCT
         CASE 
           WHEN (T1.TIPUS = 'XX' AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL)) THEN 'BREG_XX'
           WHEN (T1.TIPUS = 'XX') THEN 'BREG_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.TIPUS || '_XX'
           ELSE T1.TIPUS || '_' || T1.DIAMETRE
         END                                 "id",    
         'BOCA_REG'                          CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         CASE
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN TO_CHAR(T1.DIAMETRE) 
           ELSE null
         END                                 DNOM,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN T1.DIAMETRE
           ELSE null
         END                                 DINT,
         null                                DEXT,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø' || T1.DIAMETRE || ' mm'  
           ELSE 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø desconegut'  
         END                                 DESCRIPT,
         null                                "link",
         T2.BOCAREG_TIPUS_MARCA              BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_FIGARO.NA_V_BREG T1
           LEFT JOIN NA_FIGARO.CAT2_T_BREG_TIPUS T2 ON T1.TIPUS = T2.ID_BREG_TIPUS
  WHERE  T1.TIPUS IS NOT NULL
  UNION
  SELECT DISTINCT
         CASE 
           WHEN (T1.TIPUS = 'XX' AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL)) THEN 'BREG_XX'
           WHEN (T1.TIPUS = 'XX') THEN 'BREG_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.TIPUS || '_XX'
           ELSE T1.TIPUS || '_' || T1.DIAMETRE
         END                                 "id",     
         'BOCA_REG'                          CONNECTYPE_ID,
         null                                MATCAT_ID,
         null                                PNOM,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN TO_CHAR(T1.DIAMETRE) 
           ELSE null
         END                                 DNOM,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN T1.DIAMETRE
           ELSE null
         END                                 DINT,
         null                                DEXT,
         CASE 
           WHEN DIAMETRE > 0 AND DIAMETRE IS NOT NULL THEN 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø' || T1.DIAMETRE || ' mm'  
           ELSE 'B.Reg : ' || TRIM(SUBSTR(T2.BOCAREG_TIPUS, INSTR(T2.BOCAREG_TIPUS,' - ')+3)) || ' - Ø desconegut'  
         END                                 DESCRIPT,
         null                                "link",
         T2.BOCAREG_TIPUS_MARCA              BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_LLISSADEVALL.NA_V_BREG T1
           LEFT JOIN NA_LLISSADEVALL.CAT2_T_BREG_TIPUS T2 ON T1.TIPUS = T2.ID_BREG_TIPUS
  WHERE  T1.TIPUS IS NOT NULL
  ORDER BY "id", DINT, DEXT;



CREATE OR REPLACE VIEW TMP_CAT_CONNEC_PUNTCAR AS

  SELECT DISTINCT
         'PCAR_' || T1.MATERIAL || '_' || T1.DIAMETRE   "id",
         'PUNT_CAR'                          CONNECTYPE_ID,
         T1.MATERIAL                         MATCAT_ID,
    	   CASE
      	   WHEN INSTR(T2.PCAR_MAT,'PN') = 0
      	   THEN NULL
      	   ELSE TRIM(SUBSTR(T2.PCAR_MAT, INSTR(T2.PCAR_MAT,'PN')+2)) || ' atm'
    	   END 						                		 PNOM,
         TO_CHAR(T1.DIAMETRE)                DNOM,
         T1.DIAMETRE                         DINT,
         null                                DEXT,
         'P.Càrrega : ' || TRIM(SUBSTR(T2.PCAR_MAT, INSTR(T2.PCAR_MAT,' - ')+3)) || ' - Ø' || T1.DIAMETRE || ' mm'  DESCRIPT,
         null                                "link",
         null                                BRAND,
         null                                "model",
         null                                SVG,
         null                                COST_UT,
         null                                COST_ML,
         null                                COST_M3,
         'true'                              ACTIVE
  FROM   NA_MATARO.NA_V_PCAR T1
           LEFT JOIN NA_MATARO.CAT2_T_PCAR_MATERIAL T2 ON T1.MATERIAL = T2.ID_PCAR_MAT
  WHERE  (T1.MATERIAL IS NOT NULL OR T1.DIAMETRE IS NOT NULL)
  ORDER BY "id", DINT, DEXT;



CREATE OR REPLACE VIEW CAT_CONNEC AS
  
  SELECT * FROM TMP_CAT_CONNEC_GREENTAP
  UNION ALL
  SELECT * FROM TMP_CAT_CONNEC_PUNTCAR
  UNION ALL
  SELECT * FROM TMP_CAT_CONNEC_TAP
  UNION ALL
  SELECT * FROM TMP_CAT_CONNEC_WJOIN
  UNION
  SELECT 'FOOR_XX', 'FONT_ORN', null, null, null, null, null, 'Font Ornamental', null, null, null, null, null, null, null, 'true' FROM DUAL
  ORDER BY 2, 1;
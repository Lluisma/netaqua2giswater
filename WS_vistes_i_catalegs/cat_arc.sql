
CREATE OR REPLACE VIEW CAT_ARC AS

  SELECT DISTINCT
         T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         "id",
         'PIPE'                      ARCTYPE_ID,
         T1.ID_MATERIAL              MATCAT_ID,
         CASE
           WHEN INSTR(T2.MATERIAL,'PN') = 0
           THEN NULL
           ELSE TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,'PN')+2)) || ' atm'
         END PNOM,
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         DNOM,
         T1.DIAMETRE_NOM             DINT,
         T1.DIAMETRE_EXT             DEXT,
         TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,' - ')+3)) || ' Ø' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END || ' mm'                DESCRIPT,
         null                        "link",
         null                        BRAND,
         null                        "model",
         null                        SVG,
         null                        Z1,
         null                        Z2,
         null                        WIDTH,
         null                        AREA,
         null                        ESTIMATED_DEPTH,
         null                        "bulk",
         null                        COST_UNIT,
         null                        "cost",
         null                        M2BOTTOM_COST,
         null                        M3PROTEC_COST,
         'true'                      ACTIVE
  FROM   NA_MATARO.NA_T_TRAM T1
           LEFT JOIN NA_MATARO.CAT_T_MATERIAL T2 ON T1.ID_MATERIAL = T2.ID_MATERIAL
  WHERE  ID_TRAM <> -1
  
  UNION
  
  SELECT DISTINCT
         T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         "id",
         'PIPE'                      ARCTYPE_ID,
         T1.ID_MATERIAL              MATCAT_ID,
         CASE
           WHEN INSTR(T2.MATERIAL,'PN') = 0
           THEN NULL
           ELSE TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,'PN')+2)) || ' atm'
         END                         PNOM,
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         DNOM,
         T1.DIAMETRE_NOM             DINT,
         T1.DIAMETRE_EXT             DEXT,
         TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,' - ')+3)) || ' Ø' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END || ' mm'                DESCRIPT,
         null                        "link",
         null                        BRAND,
         null                        "model",
         null                        SVG,
         null                        Z1,
         null                        Z2,
         null                        WIDTH,
         null                        AREA,
         null                        ESTIMATED_DEPTH,
         null                        "bulk",
         null                        COST_UNIT,
         null                        "cost",
         null                        M2BOTTOM_COST,
         null                        M3PROTEC_COST,
         'true'                      ACTIVE
  FROM   NA_FIGARO.NA_T_TRAM T1
           LEFT JOIN NA_FIGARO.CAT_T_MATERIAL T2 ON T1.ID_MATERIAL = T2.ID_MATERIAL
       
  UNION
  
    SELECT DISTINCT
         T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         "id",
         'PIPE'                      ARCTYPE_ID,
         T1.ID_MATERIAL              MATCAT_ID,
         CASE
           WHEN INSTR(T2.MATERIAL,'PN') = 0
           THEN NULL
           ELSE TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,'PN')+2)) || ' atm'
         END                         PNOM,
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                         DNOM,
         T1.DIAMETRE_NOM             DINT,
         T1.DIAMETRE_EXT             DEXT,
         TRIM(SUBSTR(T2.MATERIAL, INSTR(T2.MATERIAL,' - ')+3)) || ' Ø' ||
         CASE
           WHEN T2.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END || ' mm'                DESCRIPT,
         null                        "link",
         null                        BRAND,
         null                        "model",
         null                        SVG,
         null                        Z1,
         null                        Z2,
         null                        WIDTH,
         null                        AREA,
         null                        ESTIMATED_DEPTH,
         null                        "bulk",
         null                        COST_UNIT,
         null                        "cost",
         null                        M2BOTTOM_COST,
         null                        M3PROTEC_COST,
         'true'                      ACTIVE
  FROM   NA_LLISSADEVALL.NA_T_TRAM T1
           LEFT JOIN NA_LLISSADEVALL.CAT_T_MATERIAL T2 ON T1.ID_MATERIAL = T2.ID_MATERIAL

  ORDER BY "id", DINT, DEXT;


CREATE OR REPLACE VIEW TMP_CAT_ARC AS

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
         END || ' mm'                DESCRIPT
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
         END || ' mm'                DESCRIPT
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
         END || ' mm'                DESCRIPT
  FROM   NA_LLISSADEVALL.NA_T_TRAM T1
           LEFT JOIN NA_LLISSADEVALL.CAT_T_MATERIAL T2 ON T1.ID_MATERIAL = T2.ID_MATERIAL

  ORDER BY "id", DINT, DEXT;


CREATE OR REPLACE VIEW CAT_ARC AS
  SELECT T1."id", T1.ARCTYPE_ID, T1.MATCAT_ID, T1.PNOM, T1.DNOM, T1.DINT, T1.DEXT, T1.DESCRIPT, 
         null                    AS "link",
         null                    AS BRAND,
         T2.GRUP_SECCIO          AS "model",
         null                    AS SVG,
         null                    AS Z1,
         null                    AS Z2,
         null                    AS WIDTH,
         null                    AS AREA,
         null                    AS ESTIMATED_DEPTH,
         null                    AS "bulk",
         null                    AS COST_UNIT,
         null                    AS "cost",
         null                    AS M2BOTTOM_COST,
         null                    AS M3PROTEC_COST,
         'true'                  AS ACTIVE
FROM   TMP_CAT_ARC T1
         LEFT JOIN NA_MATARO.CAT_T_DIAMETRE T2 ON T1.MATCAT_ID = T2.MAT_ID_MAT AND T1.DINT = T2.DIAMETRE;


CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_AIXETA AS
  
  SELECT  'AIX_1_' || T1.ID_FONT  element_id,
          'AIX_1_' || T1.ID_FONT  code,
          CASE
             WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC IS NULL OR AIX_ROSC = 0) THEN 'AIX_XX'
             WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC = .5) THEN 'AIX_XX_1/2'
             WHEN AIXETA IS NULL OR AIXETA = 'AL' THEN 'AIX_XX_' || AIX_ROSC
             WHEN AIX_ROSC IS NULL OR AIX_ROSC = 0 THEN 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3))
             WHEN AIX_ROSC = .5 THEN 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3)) || '_1/2'
             ELSE 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3)) || '_' || AIX_ROSC
          END                     elementcat_id,
          'AIXETA'                elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          TO_NUMBER(T1.AIX_NUME)  num_elements,
          null                    observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          null                    location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM  NA_MATARO.NA_V_FONT T1
          LEFT JOIN NA_MATARO.CAT2_T_FONT_AIXETA T2 ON T1.AIXETA = T2.ID_FONT_AIXETA
  WHERE AIXETA IS NOT NULL OR AIX_ROSC IS NOT NULL OR AIX_NUME IS NOT NULL;
  
  
CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_ARQFONT AS
  
  SELECT  'ARF_1_' || T1.ID_FONT  element_id,
          'ARF_1_' || T1.ID_FONT  code,
	        CASE
	          WHEN ARQ_SECC='C' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_DIAM
	          WHEN ARQ_SECC='Q' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_AMP || 'x' || ARQ_ALT
	          WHEN ARQ_SECC='R' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_AMP || 'x' || ARQ_ALT
	          ELSE ARQ_MATE || '_' || 'X'
	        END                     elementcat_id,
          'ARQFONT'               elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          null                    observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          null                    location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_FONT T1
  WHERE ARQ_SECC IS NOT NULL OR ARQ_MATE IS NOT NULL OR ARQ_SECC IS NOT NULL OR ARQ_DIAM IS NOT NULL;
  


CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_PORTELLA AS
  
  SELECT  'POR1_1_' || T1.ID_ESCO element_id,
          'POR1_1_' || T1.ID_ESCO code,
	        CASE
            WHEN T2.ID IS NULL THEN 'PORT_XX'
            ELSE T2.ID
          END                     elementcat_id,
          'PORTELLA'              elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          CASE
            WHEN T2.ID IS NULL THEN TRIM(T1.MAT1 || ' ' || T1.MID1)
            ELSE null
          END                     observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          T1.SIT1                 location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_ESCO T1
         LEFT JOIN TMP_CAT_ELEMENT_PORTELLA T2 ON T1.MAT1 = T2.MATCAT_ID AND T1.MID1 = T2.GEOMETRY AND T2.ELEMENTTYPE_ID = 'PORTELLA'
  WHERE T1.MAT1 IS NOT NULL OR T1.MID1 IS NOT NULL OR T1.SIT1 IS NOT NULL
  
  UNION
  
  SELECT  'POR2_1_' || T1.ID_ESCO element_id,
          'POR2_1_' || T1.ID_ESCO code,
	        CASE
            WHEN T2.ID IS NULL THEN 'PORT_XX'
            ELSE T2.ID
          END                     elementcat_id,
          'PORTELLA'              elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          CASE
            WHEN T2.ID IS NULL THEN TRIM(T1.MAT2 || ' ' || T1.MID2)
            ELSE null
          END                     observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          T1.SIT2                 location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_ESCO T1
         LEFT JOIN TMP_CAT_ELEMENT_PORTELLA T2 ON T1.MAT2 = T2.MATCAT_ID AND T1.MID2 = T2.GEOMETRY AND T2.ELEMENTTYPE_ID = 'PORTELLA'
  WHERE T1.MAT2 IS NOT NULL OR T1.MID2 IS NOT NULL OR T1.SIT2 IS NOT NULL
  
  UNION
  
  SELECT  'POR3_1_' || T1.ID_ESCO element_id,
          'POR3_1_' || T1.ID_ESCO code,
	        CASE
            WHEN T2.ID IS NULL THEN 'PORT_XX'
            ELSE T2.ID
          END                     elementcat_id,
          'PORTELLA'              elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          CASE
            WHEN T2.ID IS NULL THEN TRIM(T1.MAT3 || ' ' || T1.MID3)
            ELSE null
          END                     observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          T1.SIT3                 location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_ESCO T1
         LEFT JOIN TMP_CAT_ELEMENT_PORTELLA T2 ON T1.MAT3 = T2.MATCAT_ID AND T1.MID3 = T2.GEOMETRY AND T2.ELEMENTTYPE_ID = 'PORTELLA'
  WHERE T1.MAT3 IS NOT NULL OR T1.MID3 IS NOT NULL OR T1.SIT3 IS NOT NULL;
  


CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_ARQUETA AS
  
  SELECT  'ARQ_1_' || T1.ID_VDES  element_id,
          'ARQ_1_' || T1.ID_VDES  code,
	        CASE 
            WHEN ARQUETA = 'X-XX' AND MAT_TAPA IS NULL THEN 'X-XX'
            WHEN ARQUETA = 'X-XX' AND MAT_TAPA = 'XX' THEN 'X-XX'
            WHEN ARQUETA = 'X-XX' THEN 'X-' || MAT_TAPA
            WHEN MAT_TAPA IS NULL THEN ARQUETA
            WHEN MAT_TAPA = 'FO'  THEN ARQUETA
            ELSE ARQUETA || '_' || MAT_TAPA
          END                     elementcat_id,
          'ARQUETA'               elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          null                    observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          null                    location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_VDES T1
  WHERE T1.ARQUETA IS NOT NULL OR T1.MAT_TAPA IS NOT NULL

  UNION
  
  SELECT  'ARQB_1_' || T1.ID_BINC  element_id,
          'ARQB_1_' || T1.ID_BINC  code,
          TRAPA                   elementcat_id,
          'ARQUETA'               elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          null                    observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          null                    location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_BINC T1
  WHERE T1.TRAPA IS NOT NULL
  
  UNION
  
  SELECT  'ARQV_1_' || T1.ID_VENT element_id,
          'ARQV_1_' || T1.ID_VENT code,
          TRAPA                   elementcat_id,
          'ARQUETA'               elementtype_id,
          null                    serial_number,
          CASE T1.ESTAT
            WHEN 'A' THEN 1
            WHEN 'B' THEN 0
            ELSE -1
          END                     state,
          CAST(null AS SMALLINT)  state_type,
          null                    num_elements,
          null                    observ,
          null                    "comment",
          null                    function_type,
          null                    category_type,
          null                    location_type,
          null                    fluid_type,
          null                    workcat_id,
          null                    workcat_id_end,
          null                    buildercat_id,
          CAST(null AS DATE)      builtdate,
          CAST(null AS DATE)      enddate,
          null                    ownercat_id,
          0                       rotation,
          '-'                     link,
          null                    verified,
          null                    the_geom,
          null                    label_x,
          null                    label_y,
          0                       label_rotation,
          'true'                  publish,
          'true'                  inventory,
          null                    undelete,
          1                       expl_id
  FROM NA_MATARO.NA_V_VENT T1
  WHERE T1.TRAPA IS NOT NULL;

	
	
CREATE OR REPLACE VIEW V_EDIT_ELEMENT AS

    SELECT * FROM TMP_V_EDIT_ELEMENT_AIXETA
    UNION
    SELECT * FROM TMP_V_EDIT_ELEMENT_ARQFONT
    UNION
    SELECT * FROM TMP_V_EDIT_ELEMENT_ARQUETA
    UNION
    SELECT * FROM TMP_V_EDIT_ELEMENT_PORTELLA;
  
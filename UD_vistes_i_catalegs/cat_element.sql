
CREATE OR REPLACE VIEW TMP_CAT_ELEMENT_TAPA AS

	SELECT DISTINCT 
         CASE 
           WHEN geom1 IS NULL AND geom2 IS NULL AND (TAPA_SEC IS NULL OR TAPA_SEC='-') THEN 'TAPA_XX'
           WHEN geom1 IS NULL AND geom2 IS NULL THEN CAST('TAPA_' || id_mat || '_' || id_sec || id_art || id_blo || id_hom AS varchar2(50))
           WHEN geom2 IS NULL THEN CAST('TAPA_' || id_mat || '_' || id_sec || '_' || TO_CHAR(geom1/100,'FM0.00') || id_art || id_blo || id_hom AS varchar2(50))
           ELSE CAST('TAPA_' || id_mat || '_' || id_sec || '_' ||  TO_CHAR(geom1/100,'FM0.00') || 'x' ||  TO_CHAR(geom2/100,'FM0.00') || id_art || id_blo || id_hom AS varchar2(50))
         END                              AS "id",
	        'TAPA'                          AS elementtype_id,
	        CAST(id_mat AS varchar2(50))    AS matcat_id,
	        CASE TAPA_SEC
            WHEN '-' THEN null
            ELSE TAPA_SEC
          END                             AS geometry,
          CASE
            WHEN id_art IS NOT NULL or id_blo IS NOT NULL THEN 
              'Tapa ' || desc_mat || ' ' || desc_dim || ' :' || desc_art || desc_blo || desc_hom
            ELSE
              'Tapa ' || desc_mat || ' ' || desc_dim 
          END                             AS descript,
	        null                            AS "link",
	        null                            AS brand,
	        null                            AS "type",
	        null                            AS "model",
	        null                            AS svg,
	        'true'                          AS active,
          TAPA_MAT, TAPA_SEC, TAPA_DIM, TAPA_ART, TAPA_BLO, TAPA_HOM
	FROM (
    SELECT  DISTINCT 
            SET_ELEMENT_MAT( TAPA_MAT )     AS id_mat,
            SET_ELEMENT_SEC( TAPA_SEC )     AS id_sec,
            CASE TAPA_ART
              WHEN 1 THEN ':A'
              ELSE NULL
            END                             AS id_art,
            CASE TAPA_HOM
              WHEN 1 THEN ':H'
              ELSE NULL
            END                             AS id_hom,
            CASE TAPA_BLO
              WHEN 1 THEN ':B'
              ELSE NULL
            END                             AS id_blo,
            CASE
              WHEN SET_ELEMENT_MAT(TAPA_MAT) = 'XX' THEN 'Material desconegut'
              ELSE  INITCAP(TAPA_MAT)    
            END                             AS desc_mat,
            CASE 
              WHEN TAPA_DIM IS NULL THEN ''
              WHEN TAPA_SEC = 'CIRCULAR' THEN 'Ø ' || REPLACE(TAPA_DIM,',','.') || ' m'
              ELSE REPLACE(REPLACE(LOWER(TAPA_DIM),' x ','x'),',','.') || ' m'
            END                             AS desc_dim,
            CASE TAPA_ART
              WHEN 1 THEN ' Articulada'
              ELSE ''
            END                             AS desc_art,
            CASE TAPA_HOM
              WHEN 1 THEN ' (Homologada)'
              ELSE ''
            END                             AS desc_hom,
            CASE TAPA_BLO
              WHEN 1 THEN ' Bloquejada'
              ELSE ''
            END                             AS desc_blo,
            -- GEOKETTLE TÉ PROBLEMES AMB SEPARADOR DE DECIMALS PER APLICAR TO_NUMBER  
            CASE INSTR( REPLACE(UPPER(TAPA_DIM),' X ','X'), 'X')
              WHEN 0 THEN TO_NUMBER( REPLACE(TAPA_DIM,',','.'), '99999D999', 'NLS_NUMERIC_CHARACTERS=''.,''' )*100
              ELSE TO_NUMBER( SUBSTR( REPLACE(TAPA_DIM,',','.'), 0, INSTR( REPLACE(UPPER(TAPA_DIM),' X ','X'), 'X')-1), '99999D999', 'NLS_NUMERIC_CHARACTERS=''.,''' ) * 100
            END                             AS geom1,
            CASE INSTR( REPLACE(UPPER(TAPA_DIM),' X ','X'), 'X')
              WHEN 0 THEN NULL
              ELSE TO_NUMBER( SUBSTR( REPLACE(TAPA_DIM,',','.'), INSTR( REPLACE(UPPER(TAPA_DIM),' X ','X'), 'X')+1), '99999D999', 'NLS_NUMERIC_CHARACTERS=''.,''') * 100
            END                             AS geom2,
            TAPA_MAT, TAPA_SEC, TAPA_DIM, TAPA_ART, TAPA_BLO, TAPA_HOM
    FROM   NS_MATARO.CL_V_NODE T1
  )
	ORDER BY 1;
  
  
  
CREATE OR REPLACE VIEW TMP_CAT_ELEMENT_GRAO AS

	SELECT DISTINCT 
         CAST('GRAO_' || SET_ELEMENT_MAT( GRAONS_MAT ) AS varchar2(50))   AS "id",
	       'GRAO'                                                           AS elementtype_id,
	       CAST(SET_ELEMENT_MAT( GRAONS_MAT ) AS varchar2(50))              AS matcat_id,
         null                                                             AS geometry,
         CASE 
           WHEN GRAONS_MAT IS NULL THEN 'Graó - Material desconegut'
           WHEN GRAONS_MAT = '-'   THEN 'Graó - Material desconegut'
           ELSE 'Graó - ' || INITCAP( GRAONS_MAT )
         END                                        AS descript,
	       null                                       AS "link",
         null                                       AS brand,
	       null                                       AS "type",
	       null                                       AS "model",
	       null                                       AS svg,
	       'true'                                     AS active
	FROM   NS_MATARO.CL_V_NODE T1
  ORDER BY 1;
           
           
CREATE OR REPLACE VIEW CAT_ELEMENT AS

    SELECT "id", elementtype_id, matcat_id, geometry, descript, "link", brand, "type", "model", svg, active
    FROM   TMP_CAT_ELEMENT_TAPA
    UNION
    SELECT *
    FROM   TMP_CAT_ELEMENT_GRAO
  	ORDER BY 1;

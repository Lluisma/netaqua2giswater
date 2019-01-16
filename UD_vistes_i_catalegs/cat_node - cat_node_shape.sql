
CREATE OR REPLACE VIEW cat_node_shape AS

  SELECT 'CIRCULAR'          AS id,
         'Circular'          AS descript,
         'true'              AS active
  FROM DUAL 
  UNION
  SELECT 'CONO',        'Cono',        'true' FROM DUAL 
  UNION
  SELECT 'ESPECIAL',    'Especial',    'true' FROM DUAL 
  UNION
  SELECT 'QUADRADA',    'Quadrada',    'true' FROM DUAL 
  UNION
  SELECT 'RECTANGULAR', 'Rectangular', 'true' FROM DUAL ;


CREATE OR REPLACE VIEW CAT_NODE AS

  SELECT DISTINCT 
         CASE
           WHEN (geom1 IS NULL OR geom1 = 0) AND (cat_sec ='X') AND (cat_mat ='XX') THEN 'XX'
           WHEN (geom1 IS NULL OR geom1 = 0) AND (cat_sec ='X') THEN cat_mat || '_X'
           WHEN (geom1 IS NULL OR geom1 = 0) THEN cat_mat || '_' || cat_sec || '_X'
           WHEN SHAPE = 'CIRCULAR'         THEN cat_mat || '_' || cat_sec || '_' || LPAD( geom1, 3, '0')
           ELSE cat_mat || '_' || cat_sec || '_' || LPAD( geom1, 3, '0') || 'x' || LPAD( geom2, 3, '0')
         END                                           AS "id",
	       cat_mat                                       AS MATCAT_ID,
	       SHAPE                                         AS SHAPE,
	       CASE GEOM1
           WHEN 0 THEN null
           ELSE GEOM1/100
         END                                           AS geom1,
         GEOM2/100                                     AS geom2,
         CAST( null AS NUMBER )                        AS geom3,
	       CAST( null AS NUMBER )                        AS "value",
         CASE
           WHEN (geom1 IS NULL OR geom1 = 0) AND (cat_sec ='X') AND (cat_mat ='XX') THEN 'Desconegut'
           WHEN (geom1 IS NULL OR geom1 = 0) AND (cat_sec ='X')  THEN descr_mat || ' : Secció desconeguda'
           WHEN (geom1 IS NULL OR geom1 = 0) AND (cat_mat ='XX') THEN 'Material desconegut : ' || descr_sec
           WHEN (geom1 IS NULL OR geom1 = 0)                     THEN descr_mat || ' : ' || descr_sec
           WHEN (cat_sec = 'C' OR cat_sec='K') AND cat_mat ='XX' THEN 'Material desconegut : ' || descr_sec || ' Ø' || descr_dim
           WHEN (cat_sec = 'C' OR cat_sec='K')                   THEN descr_mat || ' : ' || descr_sec || ' Ø' || descr_dim
           WHEN cat_mat ='XX'                                    THEN 'Material desconegut : ' || descr_sec || ' ' || REPLACE(descr_dim,'x',' x ')
           ELSE                                                       descr_mat || ' : ' || descr_sec || ' ' || REPLACE(descr_dim,'x',' x ')
         END                                           AS DESCRIPT,
	       null                                          AS "link",
	       null                                          AS BRAND,
	       null                                          AS "model",
	       null                                          AS SVG,
	       CAST( null AS NUMBER )                        AS estimated_y,
	       null                                          AS COST_UNIT,
	       null                                          AS "cost",
	       'true'                                        AS ACTIVE
  FROM   (  
      SELECT DISTINCT 
             SET_CONNEC_MAT (POU_MAT)         AS cat_mat,
             SET_CONNEC_SEC(POU_SEC)          AS cat_sec,
	           CASE POU_SEC
               WHEN '-' THEN NULL 
               ELSE POU_SEC
             END                              AS SHAPE,
             -- GEOKETTLE TÉ PROBLEMES AMB SEPARADOR DE DECIMALS PER APLICAR TO_NUMBER 
	           CASE INSTR( UPPER(POU_DIM), 'X')
               WHEN 0 THEN TO_NUMBER( POU_DIM, '99999D99', 'NLS_NUMERIC_CHARACTERS=''.,''' ) * 100
               ELSE        TO_NUMBER( SUBSTR( POU_DIM, 0, INSTR( UPPER(POU_DIM), 'X')-1), '99999D99', 'NLS_NUMERIC_CHARACTERS=''.,''' ) * 100
             END                              AS geom1,
             CASE INSTR( POU_DIM, 'x')
               WHEN 0 THEN null
               ELSE        TO_NUMBER( SUBSTR( POU_DIM, INSTR( UPPER(POU_DIM), 'X')+1), '99999D99', 'NLS_NUMERIC_CHARACTERS=''.,''' ) * 100
             END                              AS geom2,
             INITCAP(POU_MAT)                 AS descr_mat,
             INITCAP(POU_SEC)                 AS descr_sec,
             POU_DIM                          AS descr_dim
      FROM NS_MATARO.CL_V_NODE
  )
  ORDER BY 1;
  


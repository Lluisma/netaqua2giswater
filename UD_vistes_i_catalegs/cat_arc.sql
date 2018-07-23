
CREATE OR REPLACE VIEW TMP_CAT_ARC AS

  SELECT DISTINCT
         CASE 
           -- CASOS ESPECIALS: SECTIPUS COINCIDENTS AMB DIMENSIONS REALS DIFERENTS
           WHEN SECTIPUS='G*A150x160'      AND DIM1=1500 AND DIM2=1800 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'G*A150x160_A'
           WHEN SECTIPUS='G*A150x160'      AND DIM1=1200 AND DIM2=2000 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'G*A150x160_B'
           WHEN SECTIPUS='AUTOMATIC*28/14' AND DIM1=600	 AND DIM2=1600 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*28/14_A'
           WHEN SECTIPUS='AUTOMATIC*28/14' AND DIM1=800	 AND DIM2=1500 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*28/14_B'
           WHEN SECTIPUS='AUTOMATIC*6/19'  AND DIM1=600	 AND DIM2=1200 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*6/19_A'
           WHEN SECTIPUS='AUTOMATIC*6/19'  AND DIM1=600	 AND DIM2=1000 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*6/19_B'
           WHEN SECTIPUS='AUTOMATIC*7/19'  AND DIM1=600	 AND DIM2=1200 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*7/19_A'
           WHEN SECTIPUS='AUTOMATIC*7/19'  AND DIM1=700	 AND DIM2=1000 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'AUTOMATIC*7/19_B'
           WHEN SECTIPUS='G*70x95'         AND DIM3=700  AND DIM4=700  THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'G*70x95_A'
           WHEN SECTIPUS='G*70x95'         AND DIM3=700	 AND DIM4=1000 THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'G*70x95_B'
           WHEN SECTIPUS='POMPEU2'         AND DIM3=1200 AND DIM4=750  THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' || 'POMPEU2_A'
           WHEN SECTIPUS='POMPEU2'         AND DIM3=1400 AND DIM4=750  THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||'POMPEU2_B'
           --
           WHEN (SECCIO='ALTRES' OR SECCIO='GALERIA' OR SECCIO='DESVIAMENT') AND SECTIPUS IS NULL 
             THEN  SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  LPAD(T1.DIM1,4,'0') || 'x' || LPAD(T1.DIM2,4,'0')
           WHEN SECCIO='ALTRES' OR SECCIO='GALERIA' OR SECCIO='DESVIAMENT'
             THEN  SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  REPLACE(SECTIPUS,' ' ,'')
           WHEN SECCIO='RIERES'  
             THEN  UPPER(SECTIPUS) || '_' || SET_ARC_MAT( T1.MATERIAL ) 
           WHEN SECCIO='CIRCULAR' 
             THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  LPAD(T1.DIM1,4,'0')
           WHEN SECCIO='OVOIDE' OR SECCIO='QUADRADA' OR SECCIO='RECTANGULAR'
             THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  LPAD(T1.DIM1,4,'0') || 'x' || LPAD(T1.DIM2,4,'0')
           WHEN SECCIO='GALERIA2'
             THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  LPAD(T1.DIM1,4,'0') || 'x' || LPAD(T1.DIM2,4,'0') || '[M' || LPAD(T1.DIM1B,4,'0') || 'x' || LPAD(T1.DIM2B,4,'0') || ']'
           WHEN SECCIO='TRIANGULAR'
             THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  LPAD(T1.DIM1,4,'0') || 'x' || LPAD(T1.DIM2,4,'0') || 'x' || LPAD(T1.DIM3,4,'0')
           ELSE '00_ERROR'
         END                          AS "id",
         CASE
           WHEN SET_ARC_MAT( T1.MATERIAL ) ='XX' THEN null
           ELSE SET_ARC_MAT( T1.MATERIAL ) 
         END                          AS matcat_id,
         T1.SECCIO || '_' || T1.MATERIAL || '_' || T1.SECTIPUS || '_' || T1.DIM1 || '_' || T1.DIM2 || '_' || T1.DIM3 || '_' || T1.DIM4 || '_' || T1.DIM1B  || '_' || T1.DIM2B  || '_' || T1.DIM3B || '_' || T1.DIM4B ID_CLAU,
         T1.SECCIO,
         T1.MATERIAL,
         T1.SECTIPUS,
         T1.DIM1,
         T1.DIM2,
         T1.DIM3,
         T1.DIM4,
         T1.DIM1B,
         T1.DIM2B,
         T1.DIM3B,
         T1.DIM4B,
         INITCAP(T1.SECCIO)           AS desc_sec,
         INITCAP(T1.MATERIAL)         AS desc_mat,
         CASE 
           WHEN (SECCIO='ALTRES' OR SECCIO='GALERIA') AND T1.SECTIPUS IS NOT NULL
             THEN  T1.DIM1 || 'x' || T1.DIM2 || ' (' || T1.SECTIPUS || ')'
           WHEN (SECCIO='ALTRES' OR SECCIO='GALERIA') 
             THEN  T1.DIM1 || 'x' || T1.DIM2 
           WHEN SECCIO='RIERES'  
             THEN  T1.DIM1 || ' (' || T1.SECTIPUS || ')'
           WHEN SECCIO='CIRCULAR' 
             THEN 'Ø ' || T1.DIM1
           WHEN SECCIO='OVOIDE' OR SECCIO='QUADRADA' OR SECCIO='RECTANGULAR'
             THEN  T1.DIM1 || 'x' || T1.DIM2
           WHEN SECCIO='GALERIA2'
             THEN  T1.DIM1 || 'x' || T1.DIM2 || ' (Model: ' || T1.DIM1B || 'x' || T1.DIM2B || ')'
           WHEN SECCIO='DESVIAMENT' 
             --THEN SET_ARC_SEC(T1.SECCIO) || '_' || SET_ARC_MAT( T1.MATERIAL ) || '_' ||  T1.DIM1 || 'x' || T1.DIM2 || '_' || T1.ESTAT
             THEN T1.DIM1 || 'x' || T1.DIM2 || ' [' || T1.ESTAT || ']'
           WHEN SECCIO='TRIANGULAR'
             THEN T1.DIM1 || 'x' || T1.DIM2 || 'x' || T1.DIM3
           ELSE '00_ERROR'
         END                          AS desc_dim
  FROM   NS_MATARO.CL_V_TRAM T1
  WHERE  T1.ESTAT <> 'H';
  
  
  CREATE OR REPLACE VIEW CAT_ARC AS

  SELECT DISTINCT
         "id",
         matcat_id,
         T1.SECCIO                    AS shape,
         T1.DIM1/1000                 AS geom1,
         CASE WHEN T1.DIM2=0  THEN null ELSE T1.DIM2/1000   END  AS geom2,
         CASE WHEN T1.DIM3=0  THEN null ELSE T1.DIM3/1000   END  AS geom3,
         CASE WHEN T1.DIM4=0  THEN null ELSE T1.DIM4/1000   END  AS geom4,
         CASE WHEN T1.DIM1B=0 THEN null ELSE T1.DIM1B/1000  END  AS geom5,
         CASE WHEN T1.DIM2B=0 THEN null ELSE T1.DIM2B/1000  END  AS geom6,
         CASE WHEN T1.DIM3B=0 THEN null ELSE T1.DIM3B/1000  END  AS geom7,
         CASE WHEN T1.DIM4B=0 THEN null ELSE T1.DIM4B/1000  END  AS geom8,
         null                         AS geom_r,
         T1.desc_sec || ' : ' || T1.desc_mat || ' ' || desc_dim AS DESCRIPT,
         null                         AS "link",
         null                         AS BRAND,
         T1.SECTIPUS                  AS "model",
         null                         AS SVG,
         null                         AS Z1,
         null                         AS Z2,
         null                         AS WIDTH,
         null                         AS AREA,
         null                         AS ESTIMATED_DEPTH,
         null                         AS "bulk",
         null                         AS COST_UNIT,
         null                         AS "cost",
         null                         AS M2BOTTOM_COST,
         null                         AS M3PROTEC_COST,
         'true'                       AS ACTIVE
  FROM   TMP_CAT_ARC T1
  ORDER BY 1;

/*

-- S'anul·la perquè s'ha optat per canviar la clau forània de gully.connec_arccat_id de cat_arc a cat_connc, 
-- per major similitud dels catàlegs de connecs i gullies

CREATE OR REPLACE VIEW TMP_CAT_ARC_GULLY AS

  SELECT DISTINCT
         CASE 
           WHEN (T1.SECCIO_CONN='0' OR T1.SECCIO_CONN IS NULL) THEN 'C_' || SET_ARC_MAT( T1.MATERIAL_CONN )
           ELSE 'C_' || SET_ARC_MAT( T1.MATERIAL_CONN ) || '_' ||  LPAD(T1.SECCIO_CONN,4,'0')
         END                          AS "id",
         CASE
           WHEN SET_ARC_MAT( T1.MATERIAL_CONN ) ='XX' THEN null
           ELSE SET_ARC_MAT( T1.MATERIAL_CONN ) 
         END                          AS matcat_id,
         T1.MATERIAL_CONN || '_' || T1.SECCIO_CONN ID_CLAU,
         'CIRCULAR'                   AS SECCIO,
         T1.MATERIAL_CONN             AS MATERIAL,
         null                         AS SECTIPUS,
         T1.SECCIO_CONN               AS DIM1,
         null                         AS DIM2,
         null                         AS DIM3,
         null                         AS DIM4,
         null                         AS DIM1B,
         null                         AS DIM2B,
         null                         AS DIM3B,
         null                         AS DIM4B,
         'Circular'                   AS desc_sec,
         INITCAP(T1.MATERIAL_CONN)    AS desc_mat,
         CASE 
           WHEN (T1.SECCIO_CONN='0' OR T1.SECCIO_CONN IS NULL) THEN 'Ø desconegut'
           ELSE 'Ø ' || T1.SECCIO_CONN
         END                          AS desc_dim
  FROM   NS_MATARO.CL_V_EMBORNAL T1
  
  UNION
  
  SELECT DISTINCT
         CASE 
           WHEN (T1.SECCIO_CONN='0' OR T1.SECCIO_CONN IS NULL) THEN 'C_' || SET_ARC_MAT( T1.MATERIAL_CONN )
           ELSE 'C_' || SET_ARC_MAT( T1.MATERIAL_CONN ) || '_' ||  LPAD(T1.SECCIO_CONN,4,'0')
         END                          AS "id",
         CASE
           WHEN SET_ARC_MAT( T1.MATERIAL_CONN ) ='XX' THEN null
           ELSE SET_ARC_MAT( T1.MATERIAL_CONN ) 
         END                          AS matcat_id,
         T1.MATERIAL_CONN || '_' || T1.SECCIO_CONN ID_CLAU,
         'CIRCULAR'                   AS SECCIO,
         T1.MATERIAL_CONN             AS MATERIAL,
         null                         AS SECTIPUS,
         T1.SECCIO_CONN               AS DIM1,
         null                         AS DIM2,
         null                         AS DIM3,
         null                         AS DIM4,
         null                         AS DIM1B,
         null                         AS DIM2B,
         null                         AS DIM3B,
         null                         AS DIM4B,
         'Circular'                   AS desc_sec,
         INITCAP(T1.MATERIAL_CONN)    AS desc_mat,
         CASE 
           WHEN (T1.SECCIO_CONN='0' OR T1.SECCIO_CONN IS NULL) THEN 'Ø desconegut'
           ELSE 'Ø ' || T1.SECCIO_CONN
         END                          AS desc_dim
  FROM   NS_MATARO.CL_V_REIXA T1;
  
  
CREATE OR REPLACE VIEW CAT_ARC AS

  SELECT "id",
         matcat_id,
         T1.SECCIO                    AS shape,
         T1.DIM1/1000                 AS geom1,
         CASE WHEN T1.DIM2=0  THEN null ELSE T1.DIM2/1000   END  AS geom2,
         CASE WHEN T1.DIM3=0  THEN null ELSE T1.DIM3/1000   END  AS geom3,
         CASE WHEN T1.DIM4=0  THEN null ELSE T1.DIM4/1000   END  AS geom4,
         CASE WHEN T1.DIM1B=0 THEN null ELSE T1.DIM1B/1000  END  AS geom5,
         CASE WHEN T1.DIM2B=0 THEN null ELSE T1.DIM2B/1000  END  AS geom6,
         CASE WHEN T1.DIM3B=0 THEN null ELSE T1.DIM3B/1000  END  AS geom7,
         CASE WHEN T1.DIM4B=0 THEN null ELSE T1.DIM4B/1000  END  AS geom8,
         null                         AS geom_r,
         T1.desc_sec || ' : ' || T1.desc_mat || ' ' || desc_dim AS DESCRIPT,
         null                         AS "link",
         null                         AS BRAND,
         null                         AS "model",
         null                         AS SVG,
         null                         AS Z1,
         null                         AS Z2,
         null                         AS WIDTH,
         null                         AS AREA,
         null                         AS ESTIMATED_DEPTH,
         null                         AS "bulk",
         null                         AS COST_UNIT,
         null                         AS "cost",
         null                         AS M2BOTTOM_COST,
         null                         AS M3PROTEC_COST,
         'true'                       AS ACTIVE
  FROM   TMP_CAT_ARC T1
  
  UNION
  
    SELECT "id",
         matcat_id,
         T1.SECCIO                    AS shape,
         T1.DIM1/1000                 AS geom1,
         CASE WHEN T1.DIM2=0  THEN null ELSE T1.DIM2/1000   END  AS geom2,
         CASE WHEN T1.DIM3=0  THEN null ELSE T1.DIM3/1000   END  AS geom3,
         CASE WHEN T1.DIM4=0  THEN null ELSE T1.DIM4/1000   END  AS geom4,
         CASE WHEN T1.DIM1B=0 THEN null ELSE T1.DIM1B/1000  END  AS geom5,
         CASE WHEN T1.DIM2B=0 THEN null ELSE T1.DIM2B/1000  END  AS geom6,
         CASE WHEN T1.DIM3B=0 THEN null ELSE T1.DIM3B/1000  END  AS geom7,
         CASE WHEN T1.DIM4B=0 THEN null ELSE T1.DIM4B/1000  END  AS geom8,
         null                         AS geom_r,
         T1.desc_sec || ' : ' || T1.desc_mat || ' ' || desc_dim AS DESCRIPT,
         null                         AS "link",
         null                         AS BRAND,
         null                         AS "model",
         null                         AS SVG,
         null                         AS Z1,
         null                         AS Z2,
         null                         AS WIDTH,
         null                         AS AREA,
         null                         AS ESTIMATED_DEPTH,
         null                         AS "bulk",
         null                         AS COST_UNIT,
         null                         AS "cost",
         null                         AS M2BOTTOM_COST,
         null                         AS M3PROTEC_COST,
         'true'                       AS ACTIVE
  FROM   TMP_CAT_ARC_GULLY T1
  
  ORDER BY 1;
*/
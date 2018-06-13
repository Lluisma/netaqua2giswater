
CREATE OR REPLACE VIEW connec_type AS

  SELECT 'CLAVEGUERO'   AS id,
         'CONNEC'       AS type,
  		   'man_connec'   AS man_table,
  		   1              AS active,
  		   1              AS code_autofill,
         'Clavegueró'   AS descript,
         NULL           AS link_path
  FROM DUAL;


CREATE OR REPLACE VIEW cat_connec AS

	SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS "id",
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN )                 AS matcat_id,
	       NULL                                               AS shape,
	       T1.SECCIO_CONN/1000                                AS geom1,
	       CAST(null AS NUMBER)                               AS geom2,
	       CAST(null AS NUMBER)                               AS geom3,
	       CAST(null AS NUMBER)                               AS geom4,
	       CAST(null AS NUMBER)                               AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX')) THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (T1.MATERIAL_CONN='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN ) = 'XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN || ' mm'
           WHEN  T1.MATERIAL_CONN = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø' || T1.SECCIO_CONN || ' mm'
         END                                                AS descript,
	       NULL                                               AS "link",
	       NULL                                               AS brand,
	       NULL                                               AS "model",
	       NULL                                               AS svg,
         NULL                                               AS cost_ut,
         NULL                                               AS cost_ml,
         NULL                                               AS cost_m3,
	       'true'                                             AS active
	FROM NS_MATARO.CL_V_CLAVEGUERO T1
  UNION
	SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN_FINCA, T1.SECCIO_CONN_FINCA ) AS "id",
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )           AS matcat_id,
	       NULL                                               AS shape,
	       T1.SECCIO_CONN_FINCA/1000                          AS geom1,
         CAST(null AS NUMBER)                               AS geom2,
	       CAST(null AS NUMBER)                               AS geom3,
	       CAST(null AS NUMBER)                               AS geom4,
	       CAST(null AS NUMBER)                               AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) AND SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )='XX') THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) AND (T1.MATERIAL_CONN_FINCA='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN_FINCA ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )='XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
           WHEN  T1.MATERIAL_CONN_FINCA = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN_FINCA ) || ' - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
         END                                                AS descript,
	       NULL                                               AS "link",
	       NULL                                               AS brand,
	       NULL                                               AS "model",
	       NULL                                               AS svg,
         NULL                                               AS cost_ut,
         NULL                                               AS cost_ml,
         NULL                                               AS cost_m3,         
	       'true'                                             AS active
	FROM NS_MATARO.CL_V_CLAVEGUERO T1
  
  UNION

  SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS "id",
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN )                 AS matcat_id,
	       NULL                                               AS shape,
	       T1.SECCIO_CONN/1000                                AS geom1,
         CAST(null AS NUMBER)                               AS geom2,
	       CAST(null AS NUMBER)                               AS geom3,
	       CAST(null AS NUMBER)                               AS geom4,
	       CAST(null AS NUMBER)                               AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX') THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (T1.MATERIAL_CONN='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN || ' mm'
           WHEN  T1.MATERIAL_CONN = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø' || T1.SECCIO_CONN || ' mm'
         END                                                AS descript,
	       NULL                                               AS "link",
	       NULL                                               AS brand,
	       NULL                                               AS "model",
	       NULL                                               AS svg,
         NULL                                               AS cost_ut,
         NULL                                               AS cost_ml,
         NULL                                               AS cost_m3,         
	       'true'                                             AS active
  FROM   NS_MATARO.CL_V_EMBORNAL T1
  
  UNION
  
  SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS "id",
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN )                 AS matcat_id,
	       NULL                                               AS shape,
	       T1.SECCIO_CONN/1000                                AS geom1,
         CAST(null AS NUMBER)                               AS geom2,
	       CAST(null AS NUMBER)                               AS geom3,
	       CAST(null AS NUMBER)                               AS geom4,
	       CAST(null AS NUMBER)                               AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX') THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (T1.MATERIAL_CONN='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN || ' mm'
           WHEN  T1.MATERIAL_CONN = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø' || T1.SECCIO_CONN || ' mm'
         END                                                AS descript,
	       NULL                                               AS "link",
	       NULL                                               AS brand,
	       NULL                                               AS "model",
	       NULL                                               AS svg,
         NULL                                               AS cost_ut,
         NULL                                               AS cost_ml,
         NULL                                               AS cost_m3,         
	       'true'                                             AS active
  FROM   NS_MATARO.CL_V_REIXA T1;
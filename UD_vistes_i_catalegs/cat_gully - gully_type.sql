
CREATE OR REPLACE VIEW gully_type AS

  SELECT 'EMBORNAL'     AS id,
         'GULLY'        AS type,
  		   'man_gully'    AS man_table,
  		   1              AS active,
  		   1              AS code_autofill,
         'Embornal'   AS descript,
         NULL           AS link_path
  FROM DUAL
  UNION
  SELECT 'REIXA', 'GULLY', 'man_gully', 1, 1, 'Reixa', NULL
  FROM DUAL;


/*

    cat_gully NO EXISTEIX *******************************************************

CREATE OR REPLACE VIEW cat_connec AS

	SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS id,
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN )                 AS matcat_id,
	       NULL                                               AS shape,
	       NULL                                               AS tsect_id,
	       NULL                                               AS curve_id,
	       T1.SECCIO_CONN                                     AS geom1,
	       NULL                                               AS geom2,
	       NULL                                               AS geom3,
	       NULL                                               AS geom4,
	       T1.SECCIO_CONN                                     AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (SET_CONNEC_MAT( T1.MATERIAL_CONN )='XX')) THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) AND (T1.MATERIAL_CONN='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN = 0 OR T1.SECCIO_CONN IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN ) = 'XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN || ' mm'
           WHEN  T1.MATERIAL_CONN = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN ) || ' - Ø' || T1.SECCIO_CONN || ' mm'
         END                                                AS descript,
	       NULL                                               AS link,
	       NULL                                               AS brand,
	       NULL                                               AS model,
	       NULL                                               AS svg,
	       1                                                  AS active
	FROM NS_MATARO.CL_V_CLAVEGUERO T1
  UNION
	SELECT DISTINCT
         SET_CONNEC_CAT( T1.MATERIAL_CONN_FINCA, T1.SECCIO_CONN_FINCA ) AS id,
    	   SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )   AS matcat_id,
	       NULL AS shape,
	       NULL AS tsect_id,
	       NULL AS curve_id,
	       T1.SECCIO_CONN_FINCA AS geom1,
	       NULL AS geom2,
	       NULL AS geom3,
	       NULL AS geom4,
	       T1.SECCIO_CONN_FINCA AS geom_r,
	       CASE
           WHEN ((T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) AND SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )='XX') THEN 'Clavegueró : Desconegut'
           WHEN ((T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) AND (T1.MATERIAL_CONN_FINCA='PVC')) THEN 'Clavegueró : PVC - Ø Desconegut'
           WHEN (T1.SECCIO_CONN_FINCA = 0 OR T1.SECCIO_CONN_FINCA IS NULL) THEN 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN_FINCA ) || ' - Ø Desconegut'
           WHEN (SET_CONNEC_MAT( T1.MATERIAL_CONN_FINCA )='XX') THEN 'Clavegueró : Desconegut - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
           WHEN  T1.MATERIAL_CONN_FINCA = 'PVC' THEN 'Clavegueró : PVC - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
           ELSE 'Clavegueró : ' || INITCAP( T1.MATERIAL_CONN_FINCA ) || ' - Ø' || T1.SECCIO_CONN_FINCA || ' mm'
         END  AS descript,
	       NULL AS link,
	       NULL AS brand,
	       NULL AS model,
	       NULL AS svg,
	       1 AS active
	FROM NS_MATARO.CL_V_CLAVEGUERO T1;
  
  
*/
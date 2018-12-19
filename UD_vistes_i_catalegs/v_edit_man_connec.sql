CREATE OR REPLACE FORCE VIEW v_edit_man_connec AS

  SELECT
    T1.ID_CLAVEGUERO                             AS connec_id,
    T1.ID_CLAVEGUERO                             AS code,
    T1.CODI_ADMI                                 AS customer_code,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) AND T4.FUNCIO='RIERES' THEN 'RIERA'
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN 'TRAM'
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN SET_NODE_FUNCTION( T3.NODE_FUN )
      ELSE null
    END                                          AS featurecat_id,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN T1.ID_TRAM
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN T1.ID_NODE
      ELSE null
    END                                          AS feature_id,
    T1.ZGRAF                                     AS top_elev,
    T1.SONDA_FINCA                               AS y1,
    T1.SONDA_CONN                                AS y2,
    SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN )              AS connecat_id,
    'CLAVEGUERO'                                 AS connec_type,
    NULL                                         AS sys_type,
    SET_CONNEC_CAT( T1.MATERIAL_CONN_FINCA, T1.SECCIO_CONN_FINCA )  AS private_connecat_id,
    '-'                                          AS cat_matcat_id,
    1                                            AS sector_id,
    CAST(null AS NUMBER)                         AS macrosector_id,
    CAST(null AS NUMBER)                         AS "demand",
    SET_STATE( T1.ESTAT )                        AS state,
    SET_STATE_TYPE( T1.ESTAT )                   AS state_type,
    CAST(null AS NUMBER)                         AS connec_depth,
    T1.LONGITUD_CONN                             AS connec_length,
    NULL                                         AS arc_id,
    SET_PART(T1.OT_PART)                         AS annotation,
    T1.OBS                                       AS observ,
    SET_PART(T1.OT_BAIXA_PART)                   AS "comment",
    CAST(null AS NUMBER)                         AS dma_id,
    CAST(null AS NUMBER)                         AS macrodma_id,
    NULL                                         AS soilcat_id,
    NULL                                         AS function_type,
    T1.NUM_CONN                                  AS category_type,
    CASE T1.AIGUES_PLUVIALS
      WHEN '1' THEN 'PLUVIAL'
      ELSE NULL
    END                                          AS fluid_type,
    REPLACE(UPPER(T1.TIPUS_CONN),' ','_')        AS location_type,    
    SET_WORKCAT(T1.EXPEDIENT, 0 )                AS workcat_id,
    SET_WORKCAT(T1.EXPBAIXA, 0 )                 AS workcat_id_end,
    NULL                                         AS buildercat_id,
    T1.DATA_ALTA                                 AS builtdate,
    T1.DATA_BAIXA                                AS enddate,
    NULL                                         AS ownercat_id,
    1                                            AS muni_id,
    CAST(null AS NUMBER)                         AS postcode,
    T1.CLACAR                                    AS streetaxis_id,
    T1.CLANUM                                    AS postnumber,
    T1.CLABIS                                    AS postcomplement,
    NULL                                         AS streetaxis2_id,
    CAST(null AS NUMBER)                         AS postnumber2,
    NULL                                         AS postcomplement2,
    NULL                                         AS descript,
    '-'                                          AS svg,
    CAST(null AS NUMBER)                         AS rotation,
    NULL                                         AS "link",
    NULL                                         AS verified,
    T2.XY_GEO                                    AS the_geom,
    NULL                                         AS undelete,    
    NULL                                         AS label_x,
    NULL                                         AS label_y,
    CAST(null AS NUMBER)                         AS label_rotation,
    CASE T1.ACCES
      WHEN '0' THEN 'false'
      WHEN '1' THEN 'true'
    END                                          AS accessibility,
    CASE T1.DIAG
      WHEN '0' THEN 'false'
      WHEN '1' THEN 'true'
      WHEN '2' THEN null
    END                                          AS diagonal,
    'true'                                       AS publish,
    'true'                                       AS inventory,
    CASE T1.ORIGEN_DESC
      WHEN 'SI' THEN 1
      WHEN 'NO' THEN 0
      ELSE NULL
    END                                          AS uncertain,
    1                                            AS expl_id,
    CAST(null AS NUMBER)                         AS num_value
  FROM NS_MATARO.CL_V_CLAVEGUERO T1
        LEFT JOIN NS_MATARO.CL3_T_CLAVEGUERO T2 ON T1.ID_CLAVEGUERO = T2.ID_CLAVEGUERO
        LEFT JOIN NS_MATARO.CL_T_NODE T3 ON T1.ID_NODE = T3.ID_NODE
        LEFT JOIN NS_MATARO.CL_T_TRAM T4 ON T1.ID_TRAM = T4.ID_TRAM;
    

    


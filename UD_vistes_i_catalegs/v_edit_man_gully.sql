
CREATE OR REPLACE FORCE VIEW GW_MIGRA_NETSANEA.tmp_v_edit_man_gully_embornal AS

  SELECT
    T1.ID_EMBORNAL                              AS gully_id,
    T1.ID_EMBORNAL                              AS CODE,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) AND T4.FUNCIO='RIERES' THEN 'RIERA'
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN 'TRAM'
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN SET_NODE_FUNCTION( T3.NODE_FUN )
      ELSE null
    END                                         AS featurecat_id,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN T1.ID_TRAM
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN T1.ID_NODE
      ELSE null
    END                                         AS feature_id,    
    T1.ZGRAF                                    AS TOP_ELEV,
    T1.PROF_EMB/100                             AS YMAX,
    NULL                                        AS sys_type,
    'EMBORNAL'                                  AS gully_type,
    1                                           AS SECTOR_ID,
    CAST(null AS NUMBER)                        AS macrosector_id,
    SET_STATE( T1.ESTAT )                       AS state,
    SET_STATE_TYPE( T1.ESTAT )                  AS state_type,
    SET_PART(T1.OT_PART)                        AS ANNOTATION,
    T1.OBS                                      AS OBSERV,
    SET_PART(T1.OT_BAIXA_PART)                  AS "COMMENT",
    CAST(null AS NUMBER)                        AS dma_id,
    TO_NUMBER(SET_MACRODMA_GULLY( T1.SECTOR ))  AS macrodma_id,
    NULL                                        AS SOILCAT_ID,
    CASE T1.TIPUS
      WHEN 'ERS'	THEN 'S'
      WHEN 'ERD'	THEN 'D'
      WHEN 'EBRS' THEN 'S'
      WHEN 'EBRD' THEN 'D'
      WHEN 'EB'   THEN 'X'
      WHEN '??'   THEN 'X'
      ELSE NULL
    END                                        AS FUNCTION_TYPE,
    CASE T1.TIPUS
      WHEN 'ERS'	THEN 'R'
      WHEN 'ERD'	THEN 'R'
      WHEN 'EBRS' THEN 'BR'
      WHEN 'EBRD' THEN 'BR'
      WHEN 'EB'   THEN 'B'
      WHEN '??'   THEN 'X'
      ELSE NULL
    END                                         AS CATEGORY_TYPE,
    NULL                                        AS FLUID_TYPE,
    NULL                                        AS LOCATION_TYPE,
    SET_WORKCAT(T1.EXPEDIENT, 0 )               AS workcat_id,
    SET_WORKCAT(T1.EXPBAIXA, 0 )                AS workcat_id_end,
    NULL                                        AS BUILDERCAT_ID,
    T1.DATA_ALTA                                AS BUILTDATE,
    T1.DATA_BAIXA                               AS ENDDATE,
    CASE T1.EXTERN
      WHEN 'SI' THEN 'PARTICULAR'
      ELSE NULL
    END                                         AS OWNERCAT_ID,
    1                                           AS muni_id,
    CAST(null AS NUMBER)                        AS postcode,
    CASE 
      WHEN T1.EMBCAR=0 THEN null
      ELSE T1.EMBCAR
    END                                         AS streetaxis_id,
    CASE 
      WHEN T1.EMBNUM=0 THEN null
      ELSE T1.EMBNUM
    END                                         AS postnumber,
    NULL                                        AS postcomplement,
    NULL                                        AS streetaxis2_id,
    CAST(null AS NUMBER)                        AS postnumber2,
    NULL                                        AS postcomplement2,
    NULL                                        AS DESCRIPT,
    NULL                                        AS ARC_ID,
    '-'                                         AS svg,
    MOD(T1.ROTACIO*-1,360)                      AS rotation,
    NULL                                        AS "link",
    NULL                                        AS VERIFIED,
    T2.XY_GEO                                   AS THE_GEOM,
    NULL                                        AS UNDELETE,
    NULL                                        AS LABEL_X,
    NULL                                        AS LABEL_Y,
    CAST(null AS NUMBER)                        AS label_rotation,
    T5."id"                                     AS gratecat_id,    
    '-'                                         AS CAT_GRATE_MATCAT,
    T1.TIP_CAI                                  AS matcat_id,
    T1.PROF_SOR/100                             AS SANDBOX,
    1                                           AS UNITS,  
    NULL                                        AS GROOVE,
    NULL                                        AS SIPHON,
    SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS CONNEC_ARCCAT_ID,
    CASE T1.LONGITUD_CONN
      WHEN 0 THEN CAST(null AS NUMBER)
      ELSE T1.LONGITUD_CONN 
    END                                         AS CONNEC_LENGTH,
    CASE T1.SONDA_CONN
      WHEN 0 THEN CAST(null AS NUMBER)
      ELSE T1.SONDA_CONN
    END                                         AS CONNEC_DEPTH,
    'true'                                      AS PUBLISH,
    'true'                                      AS INVENTORY,
    'false'                                     AS UNCERTAIN,
    1                                           AS expl_id,
    CAST(null AS NUMBER)                        AS num_value
  FROM NS_MATARO.CL_V_EMBORNAL T1
  		LEFT JOIN NS_MATARO.CL3_T_EMBORNAL T2 ON T1.ID_EMBORNAL = T2.ID_EMBORNAL
      LEFT JOIN NS_MATARO.CL_T_NODE T3 ON T1.ID_NODE = T3.ID_NODE
      LEFT JOIN NS_MATARO.CL_T_TRAM T4 ON T1.ID_TRAM = T4.ID_TRAM
      LEFT JOIN TMP_CAT_GRATE T5 ON T1.REI_FAB || '_' || T1.REI_TIP || '_' || T1.REI_MAT || '_' || T1.REI_ALT  || '_' || T1.REI_AMP = T5.id_clau;
    


CREATE OR REPLACE FORCE VIEW GW_MIGRA_NETSANEA.tmp_v_edit_man_gully_reixa AS

  SELECT
    T1.ID_REIXA                                 AS gully_id,
    T1.ID_REIXA                                 AS CODE,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) AND T4.FUNCIO='RIERES' THEN 'RIERA'
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN 'TRAM'
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN SET_NODE_FUNCTION( T3.NODE_FUN )
      ELSE null
    END                                         AS featurecat_id,
    CASE
      WHEN T1.ESTAT = 'B' THEN null
      WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN T1.ID_TRAM
      WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN T1.ID_NODE
      ELSE null
    END                                         AS feature_id,    
    T1.ZGRAF                                    AS TOP_ELEV,
    T1.PROF_REI/100                             AS YMAX,
    NULL                                        AS sys_type,
    'REIXA'                                     AS gully_type,
    1                                           AS SECTOR_ID,
    CAST(null AS NUMBER)                        AS macrosector_id,
    SET_STATE( T1.ESTAT )                       AS state,
    SET_STATE_TYPE( T1.ESTAT )                  AS state_type,
    SET_PART(T1.OT_PART)                        AS ANNOTATION,
    T1.OBS                                      AS OBSERV,
    SET_PART(T1.OT_BAIXA_PART)                  AS "COMMENT",
    CAST(null AS NUMBER)                        AS dma_id,
    TO_NUMBER(SET_MACRODMA_GULLY( T1.SECTOR ))  AS macrodma_id,
    NULL                                        AS SOILCAT_ID,
    CASE T1.TIPUS
      WHEN 'RBD'	THEN 'D'
      WHEN 'RBS'	THEN 'S'
      WHEN 'RS'   THEN 'S'
      WHEN 'RD'   THEN 'D'
      WHEN '??'   THEN 'X'
      ELSE NULL
    END                                        AS FUNCTION_TYPE,
    CASE T1.TIPUS
      WHEN 'RBD' THEN 'BR'
      WHEN 'RBS' THEN 'BR'
      WHEN 'RD'  THEN 'R'
      WHEN 'RS'  THEN 'R'
      WHEN '??'  THEN 'X'
      ELSE NULL
    END                                         AS CATEGORY_TYPE,
    NULL                                        AS FLUID_TYPE,
    NULL                                        AS LOCATION_TYPE,
    SET_WORKCAT(T1.EXPEDIENT, 0 )               AS workcat_id,
    SET_WORKCAT(T1.EXPBAIXA, 0 )                AS workcat_id_end,
    NULL                                        AS BUILDERCAT_ID,
    T1.DATA_ALTA                                AS BUILTDATE,
    T1.DATA_BAIXA                               AS ENDDATE,
    CASE T1.EXTERN
      WHEN 'SI' THEN 'PARTICULAR'
      ELSE NULL
    END                                         AS OWNERCAT_ID,
    1                                           AS muni_id,
    CAST(null AS NUMBER)                        AS postcode,
    CASE 
      WHEN T1.REICAR=0 THEN null
      ELSE T1.REICAR
    END                                         AS streetaxis_id,
    CASE 
      WHEN T1.REINUM=0 THEN null
      ELSE T1.REINUM
    END                                         AS postnumber,
    NULL                                        AS postcomplement,
    NULL                                        AS streetaxis2_id,
    CAST(null AS NUMBER)                        AS postnumber2,
    NULL                                        AS postcomplement2,
    NULL                                        AS DESCRIPT,
    NULL                                        AS ARC_ID,
    '-'                                         AS svg,
    MOD(T1.ROTACIO*-1,360)                      AS rotation,
    NULL                                        AS "link",
    NULL                                        AS VERIFIED,
    T2.XY_GEO                                   AS THE_GEOM,
    NULL                                        AS UNDELETE,
    NULL                                        AS LABEL_X,
    NULL                                        AS LABEL_Y,
    CAST(null AS NUMBER)                        AS label_rotation,
    T5."id"                                     AS gratecat_id,    
    '-'                                         AS CAT_GRATE_MATCAT,
    NULL                                        AS matcat_id,
    T1.PROF_SOR/100                             AS SANDBOX,
    T1.NUMREP                                   AS UNITS,  
    NULL                                        AS GROOVE,
    NULL                                        AS SIPHON,
    SET_CONNEC_CAT( T1.MATERIAL_CONN, T1.SECCIO_CONN ) AS CONNEC_ARCCAT_ID,
    CASE T1.LONGITUD_CONN
      WHEN 0 THEN CAST(null AS NUMBER)
      ELSE T1.LONGITUD_CONN 
    END                                         AS CONNEC_LENGTH,
    CASE T1.SONDA_CONN
      WHEN 0 THEN CAST(null AS NUMBER)
      ELSE T1.SONDA_CONN
    END                                         AS CONNEC_DEPTH,
    'true'                                      AS PUBLISH,
    'true'                                      AS INVENTORY,
    'false'                                     AS UNCERTAIN,
    1                                           AS expl_id,
    T1.AMPLE/100                                AS num_value
  FROM NS_MATARO.CL_V_REIXA T1
  		LEFT JOIN NS_MATARO.CL3_T_REIXA T2 ON T1.ID_REIXA = T2.ID_REIXA
      LEFT JOIN NS_MATARO.CL_T_NODE T3 ON T1.ID_NODE = T3.ID_NODE
      LEFT JOIN NS_MATARO.CL_T_TRAM T4 ON T1.ID_TRAM = T4.ID_TRAM
      LEFT JOIN TMP_CAT_GRATE T5 ON T1.REI_FAB || '_' || T1.REI_TIP || '_' || T1.REI_MAT || '_' || T1.ALT  || '_' || CASE WHEN LLARGADA=0 THEN T1.AMPLE ELSE T1.LLARGADA END = T5.id_clau;


CREATE OR REPLACE FORCE VIEW GW_MIGRA_NETSANEA.v_edit_man_gully AS

   SELECT * FROM GW_MIGRA_NETSANEA.TMP_V_EDIT_MAN_GULLY_EMBORNAL
   UNION ALL
   SELECT * FROM GW_MIGRA_NETSANEA.TMP_V_EDIT_MAN_GULLY_REIXA;

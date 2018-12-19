CREATE OR REPLACE FORCE VIEW v_edit_man_junction AS

  SELECT 
    T1.ID_NODE                                   AS NODE_ID,
    T1.ID_NODE                                   AS CODE,
    T1.ZTAPA                                     AS TOP_ELEV,
    CAST(null AS NUMBER)                         AS CUSTOM_TOP_ELEV,
    CASE T1.SONDA_PROV
      WHEN 'SI' THEN NULL
      ELSE T1.SOLERA_COTA
    END                                          AS ELEV,
    CASE T1.SONDA_PROV
      WHEN 'SI' THEN T1.SOLERA_COTA
      ELSE NULL
    END                                          AS CUSTOM_ELEV,
    CAST(null AS NUMBER)                         AS SYS_ELEV,
    CASE T1.SONDA_PROV
      WHEN 'SI' THEN NULL
      ELSE T1.NODE_PROF
    END                                          AS YMAX,
    CASE T1.SONDA_PROV
      WHEN 'SI' THEN T1.NODE_PROF
      ELSE NULL
    END                                          AS CUSTOM_YMAX,
    SET_NODE_FUNCTION( T1.NODE_FUN )             AS NODE_TYPE,
    'XX'                                         AS NODECAT_ID,
    1                                            AS SECTOR_ID,
    CAST(null AS NUMBER)                         AS macrosector_id,
    SET_STATE( T1.ESTAT )                        AS STATE,
    SET_STATE_TYPE( T1.ESTAT )                   AS state_type,
    SET_PART(T1.OT_PART)                         AS ANNOTATION,
    T1.OBS                                       AS OBSERV,
    SET_PART(T1.OT_BAIXA_PART)                   AS "comment",
    CAST(null AS NUMBER)                         AS dma_id,
    CAST(null AS NUMBER)                         AS macrodma_id,
    NULL                                         AS SOILCAT_ID,
    CASE T1.NODE_FUN
      WHEN 'NR' THEN 'RIERA'
      ELSE NULL
    END                                          AS FUNCTION_TYPE,
    NULL                                         AS CATEGORY_TYPE,
    NULL                                         AS fluid_type,
    CASE T1.NODE_FUN
      WHEN 'NC' THEN 'CONEGUDA'
      ELSE NULL
    END                                          AS LOCATION_TYPE,
    SET_WORKCAT( T1.EXPEDIENT, 0 )               AS WORKCAT_ID,
    SET_WORKCAT( T1.EXPBAIXA, 0 )                AS WORKCAT_ID_END,
    NULL                                         AS BUILDERCAT_ID,
    T1.DATA_ALTA                                 AS BUILTDATE,
    T1.DATA_BAIXA                                AS ENDDATE,
    NULL                                         AS OWNERCAT_ID,
    1                                            AS muni_id,
    CAST(null AS NUMBER)                         AS postcode,
    T1.CARRER                                    AS streetaxis_id,
    SET_POSTNUMBER(CARRERNUM)                    AS postnumber,
    SET_POSTCOMPLEMENT(T1.CARRERNUM)             AS postcomplement,
    T1.CARRER2                                   AS streetaxis2_id,
    CAST(null AS NUMBER)                         AS postnumber2,
    NULL                                         AS postcomplement2,
    NULL                                         AS DESCRIPT,
    '-'                                          AS svg,
    CAST(null AS NUMBER)                         AS rotation,
    NULL                                         AS "link",
    CASE T1.CONFIRMAT
      WHEN 1 THEN 'VERIFICAT'
      ELSE NULL
    END                                          AS VERIFIED,
    T2.XY_GEO                                    AS THE_GEOM,
    NULL                                         AS UNDELETE,
    T1.X_ETIQUETA                                AS LABEL_X,
    T1.Y_ETIQUETA                                AS LABEL_Y,
    CAST(null AS NUMBER)                         AS label_rotation,
    NULL                                         AS EPA_TYPE,
    'true'                                       AS PUBLISH,
    'true'                                       AS INVENTORY,
    CASE T1.DUBTOS
      WHEN 1 THEN 'true'
      ELSE 'false'
    END                                          AS UNCERTAIN,
    1                                            AS expl_id,
    CAST(null AS NUMBER)                         AS num_value,
    T1.DATA_XYZ                                  AS xyz_date,
    CASE T1.NOCONNECTAT
      WHEN 'SI' THEN 'true'
      ELSE 'false'
    END                                          AS UNCONNECTED
  FROM NS_MATARO.CL_V_NODE T1
        LEFT JOIN NS_MATARO.CL3_T_NODE T2 ON T1.ID_NODE = T2.ID_NODE
  WHERE T1.ESTAT IN ('A','B','X')
    AND T1.NODE_FUN IN ('N', 'NC', 'NF', 'NR');

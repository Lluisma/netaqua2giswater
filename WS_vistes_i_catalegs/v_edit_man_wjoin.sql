

CREATE OR REPLACE VIEW V_EDIT_MAN_WJOIN AS

SELECT  T1.ID_ESCO                           connec_id,
        T1.CODI_COM                          code,
        T1.COTA_APROX                        elevation,
        T1.FONDARIA                          depth,
        'ESCOMESA'                           connectype_id,
        CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE   
         END                                 connecat_id,       
        '-'                                  matcat_id,
        '-'                                  pnom,
        '-'                                  dnom,
        1                                    sector_id,
        1                                    macrosector_id,
        T1.CODI_COM                          customer_code,
        CAST(null AS NUMBER)                 n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                  state,
        CAST(null AS SMALLINT)               state_type,
        null                                 annotation,
        T1.OBS                               observ,
        null                                 "comment",
        T2.ZONA                              dma_id,
        null                                 presszonecat_id,
        null                                 soilcat_id,
        null                                 function_type,
        null                                 category_type,
        null                                 fluid_type,
        null                                 location_type,
        CASE 
          WHEN (T1.EXPEDIENT = '0' OR T1.EXPEDIENT IS NULL) THEN null
          WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
          ELSE T1.EXPEDIENT
        END                                  workcat_id,
        CASE 
          WHEN (T1.EXPBAIXA = '0' OR T1.EXPBAIXA IS NULL) THEN null
          WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          ELSE T1.EXPBAIXA
        END                                  workcat_id_end,
        null                                 buildercat_id,
        T1.DATA_INST                         builtdate,
        T1.DATA_BAIXA                        enddate,
        null                                 ownercat_id,
        1                                    muni_id,
        null                                 streetaxis_id,
        CAST(null AS INTEGER)                postnumber,
        null                                 postcomplement,
        null                                 streetaxis2_id,
        CAST(null AS INTEGER)                postnumber2,
        null                                 postcomplement2,
        null                                 descript,
        T1.ID_TRAM                           arc_id,
        '-'                                  svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)         rotation,
        null                                 label_x,
        null                                 label_y,
        CAST(null AS NUMBER)                 label_rotation,
        '-'                                  link,
        T1.LONGITUD                          connec_length,
        null                                 verified,
        T2.XY_GEO                            the_geom,
        null                                 undelete,
        'true'                               publish,
        'true'                               inventory,
        CAST(null AS NUMBER)                 macrodma_id,
        1                                    expl_id,
        CAST(null AS NUMBER)                 num_value,
        CAST(null AS INTEGER)                top_floor,
        null                                 cat_valve
FROM    NA_MATARO.NA_V_ESCO T1
          LEFT JOIN NA_MATARO.NA3_T_ESCO T2 ON T1.ID_ESCO = T2.ID_ESCO
WHERE   T1.ID_ESCO <> -1

UNION ALL

SELECT  T1.ID_ESCO                           connec_id,
        TO_NUMBER(T1.CODI_COM)               code,
        T1.COTA_APRO                         elevation,
        T1.FONDARIA                          depth,
        'ESCOMESA'                           connectype_id,
        CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE   
         END                                 connecat_id,       
        '-'                                  matcat_id,
        '-'                                  pnom,
        '-'                                  dnom,
        2                                    sector_id,
        2                                    macrosector_id,
        TO_NUMBER(T1.CODI_COM)               customer_code,
        CAST(null AS NUMBER)                 n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                  state,
        CAST(null AS SMALLINT)               state_type,
        null                                 annotation,
        T1.OBSERVACIONS                      observ,
        null                                 "comment",
        CAST(null AS INTEGER)                dma_id,
        null                                 presszonecat_id,
        null                                 soilcat_id,
        null                                 function_type,
        null                                 category_type,
        null                                 fluid_type,
        null                                 location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          ELSE T1.EXPEDIENT
        END                                  workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          ELSE T1.EXPBAIXA
        END                                  workcat_id_end,
        null                                 buildercat_id,
        T1.DATA_INST                         builtdate,
        T1.DATA_BAIXA                        enddate,
        null                                 ownercat_id,
        2                                    muni_id,
        null                                 streetaxis_id,
        CAST(null AS INTEGER)                postnumber,
        null                                 postcomplement,
        null                                 streetaxis2_id,
        CAST(null AS INTEGER)                postnumber2,
        null                                 postcomplement,
        null                                 descript,
        T1.ID_TRAM                           arc_id,
        '-'                                  svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)         rotation,
        null                                 label_x,
        null                                 label_y,
        CAST(null AS NUMBER)                 label_rotation,
        '-'                                  link,
        T1.LONGITUD                          connec_length,
        null                                 verified,
        MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
        null                                 undelete,
        'true'                               publish,
        'true'                               inventory,
        CAST(null AS NUMBER)                 macrodma_id,
        2                                    expl_id,
        CAST(null AS NUMBER)                 num_value,
        CAST(null AS INTEGER)                top_floor,
        null                                 cat_valve
FROM    NA_FIGARO.NA_V_ESCO T1

UNION ALL

SELECT  T1.ID_ESCO                           connec_id,
        TO_NUMBER(T1.CODI_COM)               code,
        T1.COTA_APRO                         elevation,
        T1.FONDARIA                          depth,
        'ESCOMESA'                           connectype_id,
        CASE 
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'ESCO_XX'
           WHEN (T1.MATERIAL = 'DE' OR T1.MATERIAL IS NULL) THEN 'ESCO_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.MATERIAL || '_XX'
           ELSE T1.MATERIAL || '_' || T1.DIAMETRE   
         END                                 connecat_id,       
        '-'                                  matcat_id,
        '-'                                  pnom,
        '-'                                  dnom,
        3                                    sector_id,
        3                                    macrosector_id,
        TO_NUMBER(T1.CODI_COM)               customer_code,
        CAST(null AS NUMBER)                 n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                  state,
        CAST(null AS SMALLINT)               state_type,
        null                                 annotation,
        T1.OBSERVACIONS                      observ,
        null                                 "comment",
        CAST(null AS INTEGER)                dma_id,
        null                                 presszonecat_id,
        null                                 soilcat_id,
        null                                 function_type,
        null                                 category_type,
        null                                 fluid_type,
        null                                 location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          ELSE T1.EXPEDIENT
        END                                  workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          ELSE T1.EXPBAIXA
        END                                  workcat_id_end,
        null                                 buildercat_id,
        T1.DATA_INST                         builtdate,
        T1.DATA_BAIXA                        enddate,
        null                                 ownercat_id,
        3                                    muni_id,
        null                                 streetaxis_id,
        CAST(null AS INTEGER)                postnumber,
        null                                 postcomplement,
        null                                 streetaxis2_id,
        CAST(null AS INTEGER)                postnumber2,
        null                                 postcomplement2,
        null                                 descript,
        T1.ID_TRAM                           arc_id,
        '-'                                  svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)         rotation,
        null                                 label_x,
        null                                 label_y,
        CAST(null AS NUMBER)                 label_rotation,
        '-'                                  link,
        T1.LONGITUD                          connec_length,
        null                                 verified,
        MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
        null                                 undelete,
        'true'                               publish,
        'true'                               inventory,
        CAST(null AS NUMBER)                 macrodma_id,
        3                                    expl_id,
        CAST(null AS NUMBER)                 num_value,
        CAST(null AS INTEGER)                top_floor,
        null                                 cat_valve
FROM    NA_LLISSADEVALL.NA_V_ESCO T1;

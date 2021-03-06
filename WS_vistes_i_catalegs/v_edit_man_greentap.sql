

CREATE OR REPLACE VIEW V_EDIT_MAN_GREENTAP AS

SELECT  T1.ID_BREG                        connec_id,
        T1.ID_BREG                        code,
        CAST(null AS NUMBER)              elevation,
        CAST(null AS NUMBER)              depth,
        'BOCA_REG'                        connectype_id,
        CASE 
           WHEN (T1.TIPUS = 'XX' AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL)) THEN 'BREG_XX'
           WHEN (T1.TIPUS = 'XX') THEN 'BREG_' || T1.DIAMETRE
           WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN T1.TIPUS || '_XX'
           ELSE T1.TIPUS || '_' || T1.DIAMETRE
        END                               connecat_id,
        '-'                               matcat_id,
        '-'                               pnom,
        '-'                               dnom,
        1                                 sector_id,
        1                                 macrosector_id,
        null                              customer_code,
        CAST(null AS NUMBER)              n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                               state,
        CAST(null AS SMALLINT)            state_type,
        SET_PART(T1.OT_PART)              annotation,
        null                              observ,
        SET_PART(T1.OT_BAIXA_PART)        "comment",
        CAST(null AS INTEGER)             dma_id,
        null                              presszonecat_id,
        null                              soilcat_id,
        null                              function_type,
        null                              category_type,
        null                              fluid_type,
        null                              location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          ELSE T1.EXPEDIENT
        END                               workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          ELSE T1.EXPBAIXA
        END                               workcat_id_end,
        null                              buildercat_id,
        T1.DATA_INST                      builtdate,
        T1.DATA_BAIXA                     enddate,
        null                              ownercat_id,
        1                                 muni_id,
        CAST(null AS INTEGER)             postcode,
        null                              streetaxis_id,
        CAST(null AS NUMBER)              postnumber,
        null                              postcomplement,
        null                              streetaxis2_id,
        CAST(null AS NUMBER)              postnumber2,
        null                              postcomplement2,
        null                              descript,
        null                              arc_id,
        '-'                               svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)      rotation,
        null                              label_x,
        null                              label_y,
        CAST(null AS NUMBER)              label_rotation,
        '-'                               link,
        CAST(null AS NUMBER)              connec_length,
        null                              verified,
        T2.XY_GEO                         the_geom,
        null                              undelete,
        'true'                            publish,
        'true'                            inventory,
        CAST(null AS NUMBER)              macrodma_id,
        1                                 expl_id,
        CAST(null AS NUMBER)              num_value,
        null                              linked_connec
FROM 	NA_MATARO.NA_V_BREG T1
          LEFT JOIN NA_MATARO.NA3_T_BREG T2 ON T1.ID_BREG = T2.ID_BREG

UNION ALL

SELECT  T1.ID_PCAR                        connec_id,
        T1.ID_PCAR                        code,
        CAST(null AS NUMBER)              elevation,
        CAST(null AS NUMBER)              depth,
        'PUNT_CAR'                        connectype_id,
        'PCAR_' || T1.MATERIAL || '_' || T1.DIAMETRE   connecat_id,
        '-'                               matcat_id,
        '-'                               pnom,
        '-'                               dnom,
        1                                 sector_id,
        1                                 macrosector_id,
        null                              customer_code,
        CAST(null AS NUMBER)              n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                               state,
        CAST(null AS SMALLINT)            state_type,
        SET_PART(T1.OT_PART)              annotation,
        T1.OBS                            observ,
        SET_PART(T1.OT_BAIXA_PART)        "comment",
        CAST(null AS INTEGER)             dma_id,
        null                              presszonecat_id,
        null                              soilcat_id,
        null                              function_type,
        null                              category_type,
        null                              fluid_type,
        null                              location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          ELSE T1.EXPEDIENT
        END                               workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          ELSE T1.EXPBAIXA
        END                               workcat_id_end,
        null                              buildercat_id,
        T1.DATA_INST                      builtdate,
        T1.DATA_BAIXA                     enddate,
        null                              ownercat_id,
        1                                 muni_id,
        CAST(null AS INTEGER)             postcode,
        null                              streetaxis_id,
        CAST(null AS NUMBER)              postnumber,
        null                              postcomplement,
        null                              streetaxis2_id,
        CAST(null AS NUMBER)              postnumber2,
        null                              postcomplement2,
        null                              descript,
        null                              arc_id,
        '-'                               svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)      rotation,
        null                              label_x,
        null                              label_y,
        CAST(null AS NUMBER)              label_rotation,
        '-'                               link,
        CAST(null AS NUMBER)              connec_length,
        null                              verified,
        T2.XY_GEO                         the_geom,
        null                              undelete,
        'true'                            publish,
        'true'                            inventory,
        CAST(null AS NUMBER)              macrodma_id,
        1                                 expl_id,
        CAST(null AS NUMBER)              num_value,
        null                              linked_connec
FROM    NA_MATARO.NA_V_PCAR T1
          LEFT JOIN NA_MATARO.NA3_T_PCAR T2 ON T1.ID_PCAR = T2.ID_PCAR;

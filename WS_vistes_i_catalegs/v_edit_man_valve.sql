
CREATE OR REPLACE VIEW TMP_V_EDIT_MAN_VALVE_VALV AS

  SELECT T1.ID_VALV                     node_id,
         T1.ID_VALV                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         CASE         
           WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREGULADORA'
           ELSE 'VALVULA'
         END                            nodetype_id,
         CASE         
           WHEN T1.FUNCIO = 'REGULADORA' AND T1.MARCA IS NULL AND T1.MODEL IS NULL AND T1.DIAMETRE > 0 THEN 'VREG_XX_' || T1.DIAMETRE
	         WHEN T1.FUNCIO = 'REGULADORA' AND T1.MARCA IS NULL AND T1.MODEL IS NULL THEN 'VREG_XX'
	         WHEN T1.FUNCIO = 'REGULADORA' AND T1.MODEL = 'RO' THEN  'VREG_' || T3.ID_VR_MARCA || '_XX_' || T1.DIAMETRE
	         WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREG_' || T3.ID_VR_MARCA || '_' || T4.ID_VR_MODEL || '_' || T1.DIAMETRE
           WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) THEN 'VALV_XX_' || T1.DIAMETRE
	         WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_' || T1.TIPUS || '_XX'
	         ELSE 'VALV_' || T1.TIPUS || '_' || T1.DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         1                              sector_id,
         1                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         T1.OBS                         observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         CASE T1.FUNCIO
           WHEN 'REGULADORA' THEN null
           WHEN '-' THEN null
           ELSE T1.FUNCIO
         END                            function_type,
         null                           category_type,
         null                           fluid_type,
         T1.UBICACIO                    location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         1                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         T2.XY_GEO                      the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         1                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         CASE T1.TANCADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            closed,
         CASE T1.AVARIADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         T1.SOTERRADA                   buried,
         T1.INDICADOR_REG               irrigation_indicator,
         T1.PRESSIO_EN                  pression_entry,
         T1.PRESSIO_SO                  pression_exit,
         T1.FONDARIA_EIX                depth_valveshaft,
         T1.SITUACIO_REGU               regulator_situation,
         T1.UBICACIO_REGU               regulator_location,
         T1.OBS_REGU                    regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         T1.TIPUS_ACCIONAMENT           drive_type,
         null                           cat_valve2
  FROM   NA_MATARO.NA_V_VALV T1
           LEFT JOIN NA_MATARO.NA3_T_VALV T2 ON T1.ID_VALV = T2.ID_VALV
           LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MARCA T3 ON T1.MARCA = T3.ID_VR_MARCA
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MODEL T4 ON T1.MODEL = T4.ID_VR_MODEL
           
  UNION ALL
  
  SELECT T1.ID_VALV                     node_id,
         T1.ID_VALV                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         CASE         
           WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREGULADORA'
           ELSE 'VALVULA'
         END                            nodetype_id,
         CASE 
           WHEN T1.FUNCIO = 'REGULADORA' AND T1.TIPUS = 'X-XX' AND T1.DIAMETRE = 0 THEN 'VREG_XX'
           WHEN T1.FUNCIO = 'REGULADORA' AND T1.TIPUS = 'X-XX' THEN 'VREG_' || T1.DIAMETRE
	         WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREG_' || T1.TIPUS || '_' || T1.DIAMETRE
	         WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) THEN 'VALV_XX_' || T1.DIAMETRE
	         WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_' || T1.TIPUS || '_XX'
	         ELSE 'VALV_' || T1.TIPUS || '_' || T1.DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         2                              sector_id,
         2                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         T1.OBS                         observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         CASE T1.FUNCIO
           WHEN 'REGULADORA' THEN null
           WHEN '-' THEN null
           ELSE T1.FUNCIO
         END                            function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         2                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         2                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         CASE T1.TANCADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            closed,
         CASE T1.AVARIADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         T1.SOTERRADA                   buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         null                           cat_valve2
  FROM   NA_FIGARO.NA_V_VALV T1
  
  UNION ALL
  
  SELECT T1.ID_VALV                     node_id,
         T1.ID_VALV                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         CASE         
           WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREGULADORA'
           ELSE 'VALVULA'
         END                            nodetype_id,
         CASE 
           WHEN T1.FUNCIO = 'REGULADORA' AND T1.TIPUS = 'X-XX' AND T1.DIAMETRE = 0 THEN 'VREG_XX'
           WHEN T1.FUNCIO = 'REGULADORA' AND T1.TIPUS = 'X-XX' THEN 'VREG_' || T1.DIAMETRE
	         WHEN T1.FUNCIO = 'REGULADORA' THEN 'VREG_' || T1.TIPUS || '_' || T1.DIAMETRE
	         WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) AND (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (T1.TIPUS = 'X-XX' OR T1.TIPUS IS NULL) THEN 'VALV_XX_' || T1.DIAMETRE
	         WHEN (T1.DIAMETRE = 0 OR T1.DIAMETRE IS NULL) THEN 'VALV_' || T1.TIPUS || '_XX'
	         ELSE 'VALV_' || T1.TIPUS || '_' || T1.DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         3                              sector_id,
         3                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         null                           observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         CASE T1.FUNCIO
           WHEN 'REGULADORA' THEN null
           WHEN '-' THEN null
           ELSE T1.FUNCIO
         END                            function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         3                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         3                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         CASE T1.TANCADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            closed,
         CASE T1.AVARIADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         T1.FONDARIA_EIX                depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         null                           cat_valve2
  FROM   NA_LLISSADEVALL.NA_V_VALV T1;
  
  
  CREATE OR REPLACE VIEW TMP_V_EDIT_MAN_VALVE_VDES AS

  SELECT T1.ID_VDES                     node_id,
         T1.ID_VDES                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         'VDESCARREGA'                  nodetype_id,
         CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         1                              sector_id,
         1                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         T1.OBS                         observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         1                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         T2.XY_GEO                      the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         1                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         CASE T1.AVARIA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         T1.METRES_LIN                  lin_meters,
         T1.SORTIDA_TIPUS               exit_type,
         T1.SORTIDA_CODI                exit_code,
         T1.VDES_ACCIONAMENT            drive_type,
         null                           cat_valve2
  FROM   NA_MATARO.NA_V_VDES T1
           LEFT JOIN NA_MATARO.NA3_T_VDES T2 ON T1.ID_VDES = T2.ID_VDES
           
  UNION ALL
  
  SELECT T1.ID_VDES                     node_id,
         T1.ID_VDES                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         'VDESCARREGA'                  nodetype_id,
         CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         2                              sector_id,
         2                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         T1.OBS                         observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         2                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         2                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         CASE T1.AVARIADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         null                           cat_valve2
  FROM   NA_FIGARO.NA_V_VDES T1
  
  UNION ALL
  
  SELECT T1.ID_VDES                     node_id,
         T1.ID_VDES                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         'VDESCARREGA'                  nodetype_id,
         CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         3                              sector_id,
         3                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         null                           observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         3                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         3                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         'false'                        broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         T1.FONDARIA_EIX                depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         null                           cat_valve2
  FROM   NA_LLISSADEVALL.NA_V_VDES T1;
  
  
  CREATE OR REPLACE VIEW TMP_V_EDIT_MAN_VALVE_VENT AS

  SELECT T1.ID_VENT                     node_id,
         T1.ID_VENT                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA_VENT               depth,
         'VENTOSA'                      nodetype_id,
         CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	   ELSE 'VENT_' || TIPUS || '_XX'
       	 END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         1                              sector_id,
         1                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         T1.OBS                         observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         T1.UBICACIO                    location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         1                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         T2.XY_GEO                      the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         1                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         CASE T1.AVARIADA
           WHEN 'SI' THEN 'true'
           ELSE 'false'
         END                            broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
           WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
	       END                            cat_valve2
  FROM   NA_MATARO.NA_V_VENT T1
           LEFT JOIN NA_MATARO.NA3_T_VENT T2 ON T1.ID_VENT = T2.ID_VENT
           
  UNION ALL
  
  SELECT T1.ID_VENT                     node_id,
         T1.ID_VENT                     code,
         CAST(null AS NUMBER)           elevation,
         null                           depth,
         'VENTOSA'                      nodetype_id,
         CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	   ELSE 'VENT_' || TIPUS || '_XX'
       	 END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         2                              sector_id,
         2                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         null                           observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         2                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         2                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         'false'                        broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
           WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
	       END                            cat_valve2
  FROM   NA_FIGARO.NA_V_VENT T1
  
  UNION ALL
  
  SELECT T1.ID_VENT                     node_id,
         T1.ID_VENT                     code,
         CAST(null AS NUMBER)           elevation,
         null                           depth,
         'VENTOSA'                      nodetype_id,
         CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	   ELSE 'VENT_' || TIPUS || '_XX'
       	 END                            nodecat_id,
         '-'                            cat_matcat_id,
         '-'                            cat_pnom,  
         '-'                            cat_dnom,
         null                           epa_type,
         3                              sector_id,
         3                              macrosector_id,
         null                           arc_id,
         null                           parent_id,
         CASE T1.ESTAT
           WHEN 'A' THEN 1
           WHEN 'B' THEN 0
           ELSE -1
         END                            state,
         CAST(null AS SMALLINT)         state_type,
         null                           annotation,
         null                           observ,
         null                           "comment",
         CAST(null AS INTEGER)          dma_id,
         null                           presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         null                           function_type,
         null                           category_type,
         null                           fluid_type,
         null                           location_type,
         CASE 
           WHEN T1.EXPEDIENT = '0' THEN null
           ELSE T1.EXPEDIENT
         END                            workcat_id,
         CASE 
           WHEN T1.EXPBAIXA = '0' THEN null
           ELSE T1.EXPBAIXA
         END                            workcat_id_end,
         null                           buildercat_id,
         T1.DATA_INST                   builtdate,
         T1.DATA_BAIXA                  enddate,
         null                           ownercat_id,
         3                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         CAST(null AS INTEGER)          postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         CAST(null AS INTEGER)          postnumber2,
         null                           postcomplement2,
         null                           descript,
         '-'                            svg,
         MOD(T1.ANGLE_ROTACIO*-1,360)   rotation,
         null                           label_x,
         null                           label_y,
         CAST(null AS NUMBER)           label_rotation,
         '-'                            link,
         null                           verified,
         MDSYS.SDO_GEOMETRY(2001,25831,MDSYS.SDO_POINT_TYPE(T1.XGRAF, T1.YGRAF, null), null, null) the_geom,
         null                           undelete,
         'true'                         publish,
         'true'                         inventory,
         3                              expl_id,
         CAST(null AS DOUBLE PRECISION) hemisphere,
         CAST(null AS NUMBER)           num_value,
         'false'                        closed,
         'false'                        broken,
         null                           buried,
         null                           irrigation_indicator,
         null                           pression_entry,
         null                           pression_exit,
         null                           depth_valveshaft,
         null                           regulator_situation,
         null                           regulator_location,
         null                           regulator_observ,
         null                           lin_meters,
         null                           exit_type,
         null                           exit_code,
         null                           drive_type,
         CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
           WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
	       END                            cat_valve2
  FROM   NA_LLISSADEVALL.NA_V_VENT T1;
  
  
  CREATE OR REPLACE VIEW V_EDIT_MAN_VALVE AS
  
    SELECT * FROM TMP_V_EDIT_MAN_VALVE_VALV
    UNION ALL
    SELECT * FROM TMP_V_EDIT_MAN_VALVE_VDES
    UNION ALL
    SELECT * FROM TMP_V_EDIT_MAN_VALVE_VENT;
    

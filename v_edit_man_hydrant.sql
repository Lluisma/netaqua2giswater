
CREATE OR REPLACE VIEW V_EDIT_MAN_HYDRANT AS

  SELECT T1.ID_BINC                     node_id,
         T1.ID_BINC                     code,
         CAST(null AS NUMBER)           elevation,
         T1.FONDARIA                    depth,
         'HIDRANT'                      nodetype_id,
         'HIDR_' || TIPUS || '_' || DIAMETRE  nodecat_id,
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
         T1.OBSERVACIONS                observ,
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
         null                           fire_code,
         T1.COMUNICACIO                 communication,
         CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
           WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
        END                             valve
  FROM   NA_MATARO.NA_V_BINC T1
           LEFT JOIN NA_MATARO.NA3_T_BINC T2 ON T1.ID_BINC = T2.ID_BINC

  UNION ALL
  
  SELECT T1.ID_BINC                     node_id,
         T1.ID_BINC                     code,
         CAST(null AS NUMBER)           elevation,
         CAST(null AS NUMBER)           depth,
         'HIDRANT'                      nodetype_id,
         'HIDR_' || TIPUS || '_' || DIAMETRE  nodecat_id,
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
         null                           fire_code,
         null                           communication,
         null                           valve
  FROM   NA_FIGARO.NA_V_BINC T1
  
  UNION ALL
  
  SELECT T1.ID_BINC                     node_id,
         T1.ID_BINC                     code,
         CAST(null AS NUMBER)           elevation,
         CAST(null AS NUMBER)           depth,
         'HIDRANT'                      nodetype_id,
         'HIDR_' || TIPUS || '_' || DIAMETRE  nodecat_id,
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
         null                           fire_code,
         null                           communication,
         null                           valve
  FROM   NA_LLISSADEVALL.NA_V_BINC T1;
  
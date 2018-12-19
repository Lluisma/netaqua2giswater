       
CREATE OR REPLACE VIEW V_EDIT_MAN_PUMP AS

  SELECT T1.ID_CELE                     node_id,
         T1.ID_CELE                     code,
         CAST(null AS NUMBER)           elevation,
         CAST(null AS NUMBER)           depth,
         'BOMBAMENT'                    nodetype_id,
         'BOMB_XX'                      nodecat_id,
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
         CASE T1.FORA_DE_SERVEI
           WHEN 'SI' THEN 10
           ELSE 11
         END                            state_type,
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
         1                              muni_id,
         CAST(null AS INTEGER)          postcode,
         null                           streetaxis_id,
         T1.OT_PART                     postnumber,
         null                           postcomplement,
         null                           streetaxis2_id,
         T1.OT_BAIXA_PART               postnumber2,
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
         CAST(null AS NUMBER)           max_flow,
         CAST(null AS NUMBER)           min_flow,
         CAST(null AS NUMBER)           nom_flow,
         CAST(null AS NUMBER)           power,
         CAST(null AS NUMBER)           pressure,
         T1.COTA                        elev_height,
         null                           name
  FROM   NA_MATARO.NA_V_CELE T1
           LEFT JOIN NA_MATARO.NA3_T_CELE T2 ON T1.ID_CELE = T2.ID_CELE;
  
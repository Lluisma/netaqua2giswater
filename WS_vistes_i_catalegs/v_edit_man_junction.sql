         
CREATE OR REPLACE VIEW TMP_V_EDIT_MAN_JUNCTION_NODE AS

  SELECT T1.ID_NODE                     node_id,
         T1.ID_NODE                     code,
         CAST(null AS NUMBER)           elevation,
         CAST(null AS NUMBER)           depth,
         CASE T1.NODE_TIPUS
           WHEN '-' THEN 'UNIO'
           WHEN 'A' THEN 'UNIO'
           WHEN 'C' THEN 'DERIVACIO'
           WHEN 'D' THEN 'DERIVACIO'
           WHEN 'I' THEN 'INICI_FI'
           WHEN 'S' THEN 'UNIO'
           WHEN 'T' THEN 'DERIVACIO'
           WHEN 'U' THEN 'UNIO'
           WHEN 'V' THEN 'DERIVACIO'
           WHEN 'X' THEN 'CREUAMENT'
           ELSE '00_ERR: ' || T1.NODE_TIPUS
         END                            nodetype_id,
         CASE T1.NODE_TIPUS
           WHEN '-' THEN 'UNIO_VIRTUAL'
           WHEN 'A' THEN 'UNIO_ANTIGADER'
           WHEN 'C' THEN 'DERI_COLLARI'
           WHEN 'D' THEN 'DERI_ABRA'
           WHEN 'I' THEN 'INIFI_XX'
           WHEN 'S' THEN 'UNIO_SEP'
           WHEN 'T' THEN 'DERI_TE'
           WHEN 'U' THEN 'UNIO_TRAM'
           WHEN 'V' THEN 'DERI_VIRTUAL'
           WHEN 'X' THEN 'CREU_XX'
           ELSE '00_ERR: ' || T1.NODE_TIPUS
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
         CAST(null AS NUMBER)           num_value
  FROM   NA_MATARO.NA_V_NODE T1
           LEFT JOIN NA_MATARO.NA3_T_NODE T2 ON T1.ID_NODE = T2.ID_NODE;
  
  
  CREATE OR REPLACE VIEW TMP_V_EDIT_MAN_JUNCTION_TAPS AS

  SELECT T1.ID_TAPS                     node_id,
         T1.ID_TAPS                     code,
         CAST(null AS NUMBER)           elevation,
         CAST(null AS NUMBER)           depth,
         'TAP'                          nodetype_id,
         'TAP_XX'                       nodecat_id,
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
         CAST(null AS NUMBER)           num_value
  FROM   NA_MATARO.NA_V_TAPS T1
           LEFT JOIN NA_MATARO.NA3_T_TAPS T2 ON T1.ID_TAPS = T2.ID_TAPS;
  
  
  CREATE OR REPLACE VIEW V_EDIT_MAN_JUNCTION AS
  
    SELECT * FROM TMP_V_EDIT_MAN_JUNCTION_NODE
    UNION ALL
    SELECT * FROM TMP_V_EDIT_MAN_JUNCTION_TAPS;
	
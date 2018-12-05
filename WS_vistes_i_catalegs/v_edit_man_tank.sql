        
CREATE OR REPLACE VIEW V_EDIT_MAN_TANK AS
	
  SELECT T1.ID_DIPO                     node_id,
         T1.ID_DIPO                     code,
         T1.COTA_SOLERA                 elevation,
         CAST(null AS NUMBER)           depth,
         'DIPOSIT'                      nodetype_id,
         'DIPO_XX'                      nodecat_id,
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
         CASE
           WHEN T1.PIS = 'PIS65'   THEN 'M_65'
           WHEN T1.PIS = 'PIS100'  THEN 'M_100'
           WHEN T1.PIS = 'PIS140'  THEN 'M_140'
           WHEN T1.PIS = 'PIS185'  THEN 'M_185'
           WHEN T1.PIS = 'PIS240'  THEN 'M_240'
           WHEN T1.PIS = 'PIS310'  THEN 'M_310'
           WHEN T1.PIS = 'PIS420'  THEN 'M_420'
           WHEN T1.PIS = 'PISCOND' THEN 'M_COND'
           WHEN T1.PIS = 'PISREG'  THEN 'M_REG'
           WHEN T1.PIS IS NULL     THEN NULL
           ELSE 'ERR_PRESSZONE'
         END presszonecat_id,
         CAST(null AS INTEGER)          macrodma_id,
         null                           soilcat_id,
         T1.FUNCIO                      function_type,
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
         null                           pol_id,
         T1.CAPACITAT                   vmax,
         CAST(null AS NUMBER)           vutil,
         CAST(null AS NUMBER)           area,
         T1.CLORACIO                    chlorination,
         'DIPOSIT ' || T1.ID_DIPO       name
  FROM   NA_MATARO.NA_V_DIPO T1
           LEFT JOIN NA_MATARO.NA3_T_DIPO T2 ON T1.ID_DIPO = T2.ID_DIPO;
  
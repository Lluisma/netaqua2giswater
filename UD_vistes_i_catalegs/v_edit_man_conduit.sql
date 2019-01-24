
CREATE OR REPLACE FORCE VIEW v_edit_man_conduit AS

  SELECT T1.ID_TRAM                                   AS arc_id,
         T1.ID_TRAM                                   AS code,
         T1.NODE_1                                    AS node_1,
         T1.NODE_2                                    AS node_2,
         CASE 
           WHEN N1.SONDA_PROV='SI' THEN null
           ELSE T1.SONDA_1
         END                                          AS y1,
         CASE 
           WHEN N1.SONDA_PROV='SI' THEN T1.SONDA_1
           ELSE null
         END                                          AS custom_y1,
         CASE 
           WHEN N1.SONDA_PROV='SI' THEN null
           ELSE T1.COTA_1
         END                                          AS elev1,
         CASE 
           WHEN N1.SONDA_PROV='SI' THEN T1.COTA_1
           ELSE null
         END                                          AS custom_elev1,
         CAST(null AS NUMBER)                         AS sys_elev1,
         CASE 
           WHEN N2.SONDA_PROV='SI' THEN null
           ELSE T1.SONDA_2
         END                                          AS y2,
         CASE 
           WHEN N2.SONDA_PROV='SI' THEN null
           ELSE T1.COTA_2
         END                                          AS elev2,
         CASE 
           WHEN N2.SONDA_PROV='SI' THEN T1.SONDA_2
           ELSE null
         END                                          AS custom_y2,
         CASE 
           WHEN N2.SONDA_PROV='SI' THEN T1.COTA_2
           ELSE null
         END                                          AS custom_elev2,
         CAST(null AS NUMBER)                         AS sys_elev2,
         CAST(null AS NUMBER)                         AS z1,
         CAST(null AS NUMBER)                         AS z2,
         CAST(null AS NUMBER)                         AS r1,
      	 CAST(null AS NUMBER)                         AS r2,
         T1.PENDENT                                   AS slope, 
         CASE T1.FUNCIO
           WHEN 'RIERES' THEN 'RIERA'
           ELSE 'TRAM'
         END                                          AS arc_type,
         T3."id"                                      AS arccat_id,
  		   '-'                                          AS matcat_id,
         NULL                                         AS shape,
         CAST(null AS NUMBER)                         AS cat_geom1,
         CAST(null AS NUMBER)                         AS cat_geom2,
         CAST(null AS NUMBER)                         AS gis_length,
         T1.LONGITUD                                  AS custom_length,
         'CONDUIT'                                    AS epa_type,
         1                                            AS sector_id,
         CAST(null AS NUMBER)                         AS macrosector_id,
         SET_STATE( T1.ESTAT )                        AS STATE,
         SET_STATE_TYPE( T1.ESTAT )                   AS state_type,
         SET_PART(T1.OT_PART)                         AS annotation,
         T1.OBS                                       AS observ,
         SET_PART(T1.OT_BAIXA_PART)                   AS "comment",
         CASE T1.CONFIRMAT
           WHEN 1 THEN 'true'
           --WHEN 0 THEN 'false'
           --ELSE null
           ELSE 'false'
         END                                          AS inverted_slope,
         TO_NUMBER( SET_DMA( T1.SUBSECTOR ) )         AS dma_id,
         TO_NUMBER( SET_MACRODMA_GULLY( T1.SECTOR ) ) AS macrodma_id,
         NULL                                         AS soilcat_id,
         NULL                                         AS function_type,
         SET_CONDUIT_CATEGORY( T1.FUNCIO )            AS category_type,
         SET_CONDUIT_FLUID( T1.FUNCIO )               AS fluid_type,
         NULL                                         AS location_type,
         SET_WORKCAT( T1.EXPEDIENT, 0 )               AS WORKCAT_ID,
         SET_WORKCAT( T1.EXPBAIXA, 0 )                AS WORKCAT_ID_END,
         NULL                                         AS buildercat_id,
         T1.DATA_ALTA                                 AS builtdate,
         T1.DATA_BAIXA                                AS enddate,
         CASE T1.FUNCIO
      	 	 WHEN 'PARTICULAR' THEN 'PARTICULAR'
      	 	 ELSE NULL
         END                                          AS ownercat_id,
         1                                            AS muni_id,
         CAST(null AS NUMBER)                         AS postcode,
         T1.CARRER                                    AS streetaxis_id,
         CAST(null AS NUMBER)                         AS postnumber,
         NULL                                         AS postcomplement,
         T1.CARRER2                                   AS streetaxis2_id,
         CAST(null AS NUMBER)                         AS postnumber2,
         NULL                                         AS postcomplement2,
         NULL                                         AS descript,
         NULL                                         AS "link",
         NULL                                         AS verified,
         T2.XY_GEO                                    AS the_geom,
         NULL                                         AS undelete,
         T1.X_ETIQUETA                                AS label_x,
         T1.Y_ETIQUETA                                AS label_y,
         T1.ANGLE_ROTACIO                             AS label_rotation,
         'true'                                       AS publish,
         'true'                                       AS inventory,
         CASE T1.FUNCIO
           WHEN 'DUBTOS' THEN 'true'
           ELSE 'false'
         END                                          AS UNCERTAIN,
         1                                            AS expl_id,
         T1.ORDRE                                     AS num_value
  FROM  NS_MATARO.CL_V_TRAM T1
          LEFT JOIN NS_MATARO.CL3_T_TRAM T2 ON T1.ID_TRAM = T2.ID_TRAM
          LEFT JOIN TMP_CAT_ARC T3 ON T1.SECCIO || '_' || T1.MATERIAL || '_' || T1.SECTIPUS || '_' || T1.DIM1 || '_' || T1.DIM2 || '_' || T1.DIM3 || '_' || T1.DIM4 || '_' || T1.DIM1B  || '_' || T1.DIM2B  || '_' || T1.DIM3B || '_' || T1.DIM4B = T3.ID_CLAU
          LEFT JOIN NS_MATARO.CL_V_NODE N1 ON T1.NODE_1 = N1.ID_NODE
          LEFT JOIN NS_MATARO.CL_V_NODE N2 ON T1.NODE_2 = N2.ID_NODE
  WHERE T1.ESTAT IN ('A','B','X')
  ORDER BY ARCCAT_ID;
  
  

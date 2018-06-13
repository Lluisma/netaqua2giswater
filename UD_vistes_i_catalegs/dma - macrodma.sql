
CREATE OR REPLACE VIEW DMA AS
  SELECT TO_NUMBER(SET_DMA( T1.SUBSECTOR_ID ))     AS dma_id, 
         T1.SUBSECTOR_ID                           AS "name",
         1                                         AS expl_id,
         TO_NUMBER(SET_MACRODMA( T1.SECTOR_ID ))   AS macrodma_id,
         'Mataró - ' || T1.SUBSECTOR_ID            AS descript,
         'true'                                    AS undelete,
         SDO_GEOMETRY(2007, 25831, NULL, T1.SUBSECTOR_GEO.SDO_ELEM_INFO, T1.SUBSECTOR_GEO.SDO_ORDINATES) AS the_geom
  FROM   NS_MATARO.BASE_CL_SUBSECTOR T1;


CREATE OR REPLACE VIEW MACRODMA AS
  SELECT TO_NUMBER(SET_MACRODMA( T1.SECTOR_ID ))   AS macrodma_id, 
         T1.SECTOR_ID                              AS "name",
         1                                         AS expl_id,
         'Mataró - ' || T1.SECTOR_ID               AS descript,
         'true'                                    AS undelete,
         SDO_GEOMETRY(2007, 25831, NULL, T1.SECTOR_GEO.SDO_ELEM_INFO, T1.SECTOR_GEO.SDO_ORDINATES) AS the_geom
  FROM   NS_MATARO.BASE_CL_SECTOR T1
  
  UNION ALL
  
  SELECT 0, '-', 1, 'Mataró - Altres', 'true', null FROM DUAL
  
  ORDER BY 1;
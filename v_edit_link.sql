
CREATE OR REPLACE VIEW V_EDIT_LINK AS

-- NA_FIGARO: GEOMETRIES 2006 (MULTILINIA)

SELECT ROWNUM                           link_id, 
       null                             feature_type,
       null                             feature_id,
       null                             exit_type,
       null                             exit_id,
                                        sector_id,
                                        macrosector_id,
       CAST(null AS INTEGER)            dma_id,
       CAST(null AS INTEGER)            macrodma_id,
                                        expl_id,
       1                                state,
       CAST(null AS DOUBLE PRECISION)   gis_length,
       'true'                           userdefined_geom,
                                        the_geom
FROM (

  SELECT 1                                sector_id,
         1                                macrosector_id,
         1                                expl_id,
         T1.XY_GEO                        the_geom       
  FROM   NA_MATARO.NA3B_T_ESCO_TUB T1

  UNION ALL

  SELECT 2                                sector_id,
         2                                macrosector_id,
         2                                expl_id,
         SDO_GEOMETRY(2002, 25831, NULL, T1.THE_GEOM.SDO_ELEM_INFO, T1.THE_GEOM.SDO_ORDINATES) the_geom
  FROM  FIGARO_NA3B_T_ESCO_TUB T1
  
) TA;

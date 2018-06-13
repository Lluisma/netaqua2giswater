
CREATE OR REPLACE VIEW V_EDIT_LINK AS

  SELECT ROWNUM                           AS link_id, 
         null                             AS feature_type,
         null                             AS feature_id,
         null                             AS exit_type,
         null                             AS exit_id,
         1                                AS sector_id,
         CAST(null AS INTEGER)            AS macrosector_id,
         CAST(null AS INTEGER)            AS dma_id,
         CAST(null AS INTEGER)            AS macrodma_id,
         1                                AS expl_id,
         CASE T1.CAPA
           WHEN 'CL_CONNEXIONS' THEN 1
           WHEN 'PRJ_CL_CONNEXIONS' THEN 2
         END                              AS state,
         CAST(null AS DOUBLE PRECISION)   AS gis_length,
         'true'                           AS userdefined_geom,
         T1.XY_GEO                        AS the_geom
  FROM   NS_MATARO.CL3_T_CONNEXIO T1;


CREATE OR REPLACE VIEW V_EDIT_POND AS

SELECT T1.ID_BASS             pond_id,
       CASE
         WHEN T1.ID_ESCO = 0 THEN null
         ELSE T1.ID_ESCO
       END                    connec_id,
       CAST(null AS INTEGER)  dma_id,
       CAST(null AS INTEGER)  macrodma_id,
       1                      state,
       T1.XY_GEO              the_geom,
       1                      expl_id
FROM   NA_MATARO.NA3_T_BASS T1;


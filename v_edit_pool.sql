
CREATE OR REPLACE VIEW V_EDIT_POOL AS

SELECT T1.ID_PISC             pool_id,
       T1.ID_ESCO             connec_id,
       CAST(null AS INTEGER)  dma_id,
       CAST(null AS INTEGER)  macrodma_id,
       1                      state,
       T1.XY_GEO              the_geom,
       1                      expl_id
FROM   NA_MATARO.NA3_T_PISC T1;


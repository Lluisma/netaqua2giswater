
CREATE OR REPLACE VIEW TMP_V_EDIT_SAMPLEPOINT AS

SELECT T1.ID_MOST                      sample_id_0,
       T1.ID_MOST                      code,    
       T1.CODI_LAB                     lab_code,
       CASE T1.ELEM_TIPUS
         WHEN 'ESCO' THEN T4.ID_ESCO
         WHEN 'FONT' THEN T3.ID_FONT
         ELSE T1.ELEM_CODI
       END                             feature_id,
       CASE T1.ELEM_TIPUS
         WHEN 'ESCO' THEN 'ESCOMESA'
         WHEN 'FOOR' THEN 'FONT_ORN'
         WHEN 'CAPT' THEN 'CAPTACIO'
         WHEN 'POUS' THEN 'POU'
         WHEN 'TRAM' THEN 'PIPE'
         WHEN 'PCAR' THEN 'PUNT_CAR'
         WHEN 'FONT' THEN 'FONT'
         WHEN 'DIPO' THEN 'DIPOSIT'
         ELSE T1.ELEM_TIPUS
       END                             featurecat_id,
       CAST(null AS INTEGER)           dma_id,
       CAST(null AS INTEGER)           macrodma_id,
       CASE
         WHEN T1.PIS_PRES = 'PIS65'   THEN 'M_65'
         WHEN T1.PIS_PRES = 'PIS100'  THEN 'M_100'
         WHEN T1.PIS_PRES = 'PIS140'  THEN 'M_140'
         WHEN T1.PIS_PRES = 'PIS185'  THEN 'M_185'
         WHEN T1.PIS_PRES = 'PIS240'  THEN 'M_240'
         WHEN T1.PIS_PRES = 'PIS310'  THEN 'M_310'
         WHEN T1.PIS_PRES = 'PIS420'  THEN 'M_420'
         WHEN T1.PIS_PRES = 'PISCOND' THEN 'M_COND'
         WHEN T1.PIS_PRES = 'PISREG'  THEN 'M_REG'
         WHEN T1.PIS_PRES IS NULL THEN null
         ELSE 'ERR_PRESSZONE'
       END                             presszonecat_id,
       CASE T1.ESTAT
         WHEN 'A' THEN 1
         WHEN 'B' THEN 0          
         ELSE -1
       END                             state,
       T1.DATA_INST                    builtdate,
       T1.DATA_BAIXA                   enddate,
       CASE
         WHEN T1.EXPEDIENT = '0' OR T1.EXPEDIENT IS NULL THEN null
         WHEN T1.OT_PART = '0' OR T1.OT_PART IS NULL THEN T1.EXPEDIENT
         ELSE T1.EXPEDIENT || '-' || T1.OT_PART
       END                             workcat_id,
       CASE 
         WHEN T1.EXPBAIXA = '0' OR T1.EXPBAIXA IS NULL THEN null
         WHEN T1.OT_BAIXA_PART = '0' OR T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
         ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
       END                             workcat_id_end,
       T1.ANGLE_ROTACIO                rotation,
       1                               muni_id,
       CAST(null AS INTEGER)           postcode,
       TO_NUMBER(REPLACE(T1.CARRER1,',1',''))     streetaxis_id,
       CAST(null AS INTEGER)           postnumber,
       null                            postcomplement,
       TO_NUMBER(REPLACE(T1.CARRER2,',1',''))     streetaxis2_id,
       CAST(null AS INTEGER)           postnumber2,
       null                            postcomplement2,
       T1.INDRET                       place_name,
       T1.ARMARI                       cabinet,
       T1.OBS                          observations,
       null                            verified,
       T2.XY_GEO                       the_geom,
       1                               expl_id
FROM   NA_MATARO.NA_V_MOST T1
         LEFT JOIN NA_MATARO.NA3_T_MOST T2 ON T1.ID_MOST = T2.ID_MOST
         LEFT JOIN NA_MATARO.NA_V_FONT T3 ON T1.ELEM_CODI = T3.CODI_LAB 
         LEFT JOIN NA_MATARO.NA_V_ESCO T4 ON T1.ELEM_CODI = T4.CODI_COM;


-- CAL ELIMINAR LES REFERÈNCIES A FONTS ANTIGUES AMB CODI_LABO COINCIDENT AMB FONTS ACTUALS

CREATE OR REPLACE VIEW V_EDIT_SAMPLEPOINT AS

  SELECT ROWNUM sample_id, 
         T1.code, T1.lab_code, T1.feature_id, T1.featurecat_id, T1.dma_id, T1.macrodma_id, T1.presszonecat_id,
         T1.state, T1.builtdate, T1.enddate, T1.workcat_id, T1.workcat_id_end, T1.rotation,
         T1.muni_id, T1.postcode, T1.streetaxis_id, T1.postnumber, T1.postcomplement, 
         T1.streetaxis2_id, T1.postnumber2, T1.postcomplement2, T1.place_name,
         T1.cabinet, T1.observations, T1.verified, T1.the_geom, T1.expl_id
  FROM (
    SELECT T1.*
    FROM   tmp_v_edit_samplepoint T1
             LEFT JOIN (SELECT sample_id_0, MAX(feature_id) FEATURE_ID_MAX
                        FROM   tmp_v_edit_samplepoint
                        GROUP BY sample_id_0) T2 
               ON T1.sample_id_0 = T2.sample_id_0 AND T1.feature_id = T2.FEATURE_ID_MAX 
    WHERE  (feature_id IS NOT NULL AND T2.FEATURE_ID_MAX IS NOT NULL) OR T1.feature_id IS NULL
    ORDER BY T1.sample_id_0
  ) T1; 
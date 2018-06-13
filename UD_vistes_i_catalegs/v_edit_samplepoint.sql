
CREATE OR REPLACE VIEW V_EDIT_SAMPLEPOINT AS

SELECT T1.ID_MOSTREIG                  AS sample_id,
       T1.ID_MOSTREIG                  AS code,    
       T1.CODI_LAB                     AS lab_code,
       CASE
         WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) AND T4.FUNCIO='RIERES' THEN 'RIERA'
         WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN 'TRAM'
         WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN SET_NODE_FUNCTION( T3.NODE_FUN )
         ELSE null
       END                             AS featurecat_id,
       CASE
         WHEN (T1.ID_TRAM IS NOT NULL AND T1.ID_TRAM<>0) THEN T1.ID_TRAM
         WHEN (T1.ID_NODE IS NOT NULL AND T1.ID_NODE<>0) THEN T1.ID_NODE
         ELSE null
       END                             AS feature_id,
       CAST(null AS INTEGER)           AS dma_id,
       CAST(null AS INTEGER)           AS macrodma_id,
       SET_STATE( T1.ESTAT )           AS state,
       CAST(null AS DATE)              AS builtdate,
       CAST(null AS DATE)              AS enddate,
       null                            AS workcat_id,
       null                            AS workcat_id_end,
       CAST(null AS INTEGER)           AS rotation,
       1                               AS muni_id,
       CAST(null AS INTEGER)           AS postcode,
       TO_NUMBER(REPLACE(T1.CARRER1,',1',''))  AS streetaxis_id,
       CAST(null AS INTEGER)           AS postnumber,
       null                            AS postcomplement,
       TO_NUMBER(REPLACE(T1.CARRER2,',1',''))  AS streetaxis2_id,
       CAST(null AS INTEGER)           AS postnumber2,
       null                            AS postcomplement2,
       null                            AS place_name,
       null                            AS cabinet,
       T1.OBS                          AS observations,
       null                            verified,
       T2.XY_GEO                       the_geom,
       1                               expl_id
FROM   NS_MATARO.CL_V_MOSTREIG T1
        LEFT JOIN NS_MATARO.CL3_T_MOSTREIG T2 ON T1.ID_MOSTREIG = T2.ID_MOSTREIG
        LEFT JOIN NS_MATARO.CL_T_NODE T3 ON T1.ID_NODE = T3.ID_NODE
        LEFT JOIN NS_MATARO.CL_T_TRAM T4 ON T1.ID_TRAM = T4.ID_TRAM;

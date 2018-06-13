

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_RESULT_CONNEC AS

  SELECT ROWNUM AS "id", result_id, connec_id, the_geom
  FROM ( SELECT T1.*, MDSYS.SDO_GEOMETRY(2001, 25831, MDSYS.SDO_POINT_TYPE( XGRAF, YGRAF, null), null, null) AS the_geom
         FROM ( SELECT DISTINCT TNC_ID_TANCAMENT  AS result_id, ELE_ID_ELEMENT AS connec_id
                FROM   NA_MATARO.NA_T_TANCAMENT_ABONAT ) T1
           LEFT JOIN NA_MATARO.NA_V_ESCO T2 ON T1.connec_id= T2.ID_ESCO
         ORDER BY 1, 2 );


CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_RESULT_HYDROMETER AS

  SELECT ROWNUM AS "id", result_id, hydrometer_id
  FROM ( SELECT DISTINCT TNC_ID_TANCAMENT  AS result_id, CODI_ABONAT AS hydrometer_id
         FROM   NA_MATARO.NA_T_TANCAMENT_ABONAT 
         ORDER BY 1, 2 );
           
       
CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_RESULT_CAT AS

  SELECT  T1.ID_TANCAMENT                       AS "id",
          T1.ORDRE                              AS work_order,
          CASE T1.ESTAT
            WHEN '0' THEN 0
            WHEN '1' THEN 1
            ELSE 2
          END                                   AS mincut_state,
          1                                     AS mincut_class,
          T1.TTN_CODI                           AS mincut_type,
          T1.DATA_RECEPCIO                      AS received_date,
          1                                     AS expl_id,
          1                                     AS macroexpl_id,
          T1.CARR_MUN_ID_MUNICIPI               AS muni_id,
          CAST( null AS VARCHAR2(16))           AS postcode,
          T1.CARR_CODI                          AS streetaxis_id,
          T1.NUMERO                             AS postnumber,
          CASE T1.CAUSA
            WHEN '1' THEN 'Fortuïta'
            WHEN '2' THEN 'Provocada'
            WHEN '3' THEN 'Programada'
            ELSE '00_ERROR'
          END                                   AS anl_cause,
          T1.DATA_RECEPCIO                      AS anl_tstamp,
          LOWER(T1.USU_ID_USUARI)               AS anl_user,
          T1.DESCRIPCIO                         AS anl_descript,
          T1.TRA_ID_TRAM                        AS anl_feature_id,
          'ARC'                                 AS anl_feature_type,
          MDSYS.SDO_GEOMETRY(2001, 25831, MDSYS.SDO_POINT_TYPE( T1.COORDX, T1.COORDY, null), null, null) AS anl_the_geom,
          T1.DATAINICI                          AS forecast_start,
          T1.DATAFINAL                          AS forecast_end,
          T3.ALIAS_USER                         AS assigned_to,
          T2.SUBTANCAT                          AS exec_start,
          T2.DATARESTABLIMENT                   AS exec_end,
          null                                  AS exec_user,
          TRIM( T2.PROVOCATPER || ' ' || OBS )  AS exec_descript,
          CAST(null AS MDSYS.SDO_GEOMETRY)      AS exec_the_geom,
          REPLACE(T2.DISTFACANA,',','.')        AS exec_from_plot,
          REPLACE(T2.PROFUNDITAT,',','.')       AS exec_depth,
          --CAST(null AS NUMBER)                  AS exec_from_plot,
          --CAST(null AS NUMBER)                  AS exec_depth,
          CASE T1.PROCEDENT
            WHEN 'N' THEN 'false'
            ELSE 'true'
          END                                   AS exec_appropiate
  FROM    NA_MATARO.NA_T_TANCAMENT T1
            LEFT JOIN NA_MATARO.NA_T_TANCAMENT_ADMIN T2 ON T1.ID_TANCAMENT = T2.TNC_ID_TANCAMENT
            LEFT JOIN TMP_CAT_USERS T3 ON T2.ID_OPERARIASSIGNAT = T3.ID_USER;


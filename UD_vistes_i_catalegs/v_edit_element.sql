
CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_TAPA AS
  
  SELECT  'TAPA_' || T1.ID_NODE                         AS element_id,
          'TAPA_' || T1.ID_NODE                         AS code,
          CASE 
            WHEN T3."id" IS NULL THEN 'TAPA_XX'
            ELSE CAST(T3."id" AS varchar2(50))
          END                                           AS elementcat_id,
          'TAPA'                                        AS elementtype_id,
          null                                          AS serial_number,
          SET_STATE( T1.ESTAT )                         AS STATE,
          SET_STATE_TYPE( T1.ESTAT )                    AS state_type,
          CAST(null AS INTEGER)                         AS num_elements,
          null                                          AS observ,
          null                                          AS "comment",
          null                                          AS function_type,
          null                                          AS category_type,
          REPLACE(REPLACE(T1.TAPA_SIT,' ',''),'Í','I')  AS location_type,
          null                                          AS fluid_type,
          null                                          AS workcat_id,
          null                                          AS workcat_id_end,
          null                                          AS buildercat_id,
          CAST(null AS DATE)                            AS builtdate,
          CAST(null AS DATE)                            AS enddate,
          CASE T1.NODE_FUN
            WHEN 'PP' THEN 'PARTICULAR'
            ELSE NULL
          END                                           AS OWNERCAT_ID,
          CAST(null AS NUMBER)                          AS rotation,
          null                                          AS "link",
          null                                          AS verified,
          T2.XY_GEO                                     AS the_geom,
          null                                          AS label_x,
          null                                          AS label_y,
          CAST(null AS NUMBER)                          AS label_rotation,
          'true'                                        AS publish,
          'true'                                        AS inventory,
          null                                          AS undelete,
          1                                             AS expl_id
  FROM  NS_MATARO.CL_V_NODE T1
          LEFT JOIN NS_MATARO.CL3_T_NODE T2 ON T1.ID_NODE = T2.ID_NODE
          LEFT JOIN TMP_CAT_ELEMENT_TAPA T3 ON T1.TAPA_MAT = T3.TAPA_MAT
                                           AND T1.TAPA_SEC = T3.TAPA_SEC
                                           AND T1.TAPA_DIM = T3.TAPA_DIM
                                           AND T1.TAPA_ART = T3.TAPA_ART
                                           AND T1.TAPA_BLO = T3.TAPA_BLO
                                           AND T1.TAPA_HOM = T3.TAPA_HOM
  WHERE T1.ESTAT IN ('A','B','X')
    AND (   T1.TAPA_MAT IS NOT NULL
         OR T1.TAPA_SEC    IS NOT NULL
         OR T1.TAPA_DIM    IS NOT NULL);
  

CREATE OR REPLACE VIEW TMP_V_EDIT_ELEMENT_GRAONS AS
  
  SELECT  'GRAO_' || T1.ID_NODE                       AS element_id,
          'GRAO_' || T1.ID_NODE                       AS code,
	        CAST('GRAO_' || SET_ELEMENT_MAT(T1.GRAONS_MAT) AS varchar2(50))  AS elementcat_id,
          'GRAO'                                      AS elementtype_id,
          null                                        AS serial_number,
          SET_STATE( T1.ESTAT )                       AS STATE,
          SET_STATE_TYPE( T1.ESTAT )                  AS state_type,
          T1.GRAONS_NUM                               AS num_elements,
          null                                        AS observ,
          null                                        AS "comment",
          null                                        AS function_type,
          null                                        AS category_type,
          null                                        AS location_type,
          null                                        AS fluid_type,
          null                                        AS workcat_id,
          null                                        AS workcat_id_end,
          null                                        AS buildercat_id,
          CAST(null AS DATE)                          AS builtdate,
          CAST(null AS DATE)                          AS enddate,
          CASE T1.NODE_FUN
            WHEN 'PP' THEN 'PARTICULAR'
            ELSE NULL
          END                                         AS OWNERCAT_ID,
          CAST(null AS NUMBER)                        AS rotation,
          null                                        AS "link",
          null                                        AS verified,
          null                                        AS the_geom,
          null                                        AS label_x,
          null                                        AS label_y,
          CAST(null AS NUMBER)                        AS label_rotation,
          'true'                                      AS publish,
          'true'                                      AS inventory,
          null                                        AS undelete,
          1                                           AS expl_id
  FROM  NS_MATARO.CL_V_NODE T1
  WHERE (     T1.GRAONS_MAT IS NOT NULL 
         OR  (T1.GRAONS_NUM IS NOT NULL AND T1.GRAONS_NUM>0))
    AND T1.ESTAT IN ('A','B','X');
  

CREATE OR REPLACE VIEW V_EDIT_ELEMENT AS

    SELECT * FROM TMP_V_EDIT_ELEMENT_TAPA
    UNION ALL
    SELECT * FROM TMP_V_EDIT_ELEMENT_GRAONS;


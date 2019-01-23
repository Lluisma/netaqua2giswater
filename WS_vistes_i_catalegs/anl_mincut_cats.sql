 
CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_CAT_CAUSE AS

    SELECT 1                 AS "id",
           'Fortuïta'        AS descript
    FROM   DUAL
    UNION
    SELECT 2, 'Programada'  FROM DUAL
    UNION
    SELECT 3, 'Provocada'   FROM DUAL;

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_CAT_CLASS AS

    SELECT 1                     AS "id",
           'Tancament de Xarxa'  AS "name",
           null                  AS descript
    FROM   DUAL
    UNION
    SELECT 2, 'Tancament d''Escomesa', NULL FROM DUAL
    UNION
    SELECT 3, 'Tancament d''Abonat',   NULL FROM DUAL;


CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_CAT_STATE AS

    SELECT 0               AS "id",
           'Planificat'    AS "name",
           null            AS descript
    FROM   DUAL
    UNION
    SELECT 1, 'Actiu',       NULL FROM DUAL
    UNION
    SELECT 2, 'Finalitzat',  NULL FROM DUAL;
    

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_CAT_TYPE AS

  SELECT CODI              AS "id", 
         CASE TANC_REAL
           WHEN 'S' THEN 'false'
           ELSE 'true'
         END               AS virtual,
         TIPUS_TANCAMENT   AS descript
  FROM NA_MATARO.CAT_T_TIPUS_TANCAMENT
  ORDER BY CODI;
  

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ANL_MINCUT_SELECTOR_VALVE AS

  SELECT 'VALVULA'         AS "id"
  FROM DUAL;
  
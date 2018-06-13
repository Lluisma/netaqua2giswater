

-- ABASTAMENT

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.CAT_OWNER AS

    SELECT 'PRIVAT'       AS id,
           null           AS descript,
           null           AS link
    FROM   DUAL
    UNION
    SELECT 'EXTERN', null, null
    FROM   DUAL;


-- CLAVEGUERAM

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.CAT_OWNER AS

    SELECT 'PARTICULAR'   AS id,
           'Particular'   AS descript,
           null           AS link
    FROM   DUAL;

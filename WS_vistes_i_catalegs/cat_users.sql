

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.CAT_USERS AS

    SELECT ALIAS_USER                 AS "id",
           NOM_USER                  AS "name",
           null                       AS "context"
    FROM   TMP_CAT_USERS;
  
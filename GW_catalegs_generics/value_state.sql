
CREATE OR REPLACE VIEW VALUE_STATE AS

  	SELECT 0               AS id,
    	     'BAIXA'         AS name,
           'OBSOLETE'      AS observ
    FROM DUAL
    UNION
    SELECT 1               AS id,
           'ALTA'          AS name,
           'ON SERVICE'    AS observ
    FROM   DUAL
    UNION
    SELECT 2               AS id,
           'PLANIFICAT'    AS name,
           'PLANIFIED'     AS observ
    FROM   DUAL;

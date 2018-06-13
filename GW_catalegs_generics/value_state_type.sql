
-- ABASTAMENT 

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.VALUE_STATE_TYPE AS
	
    SELECT 0           	      AS id,
           0                  AS state,
    	     'BAIXA'           	AS name,
           'false'            AS is_operative,
           'false'            AS is_doable
    FROM DUAL
    UNION
    SELECT  10, 1, 'FORA DE SERVEI', 'false', 'true'
    FROM DUAL
    UNION
    SELECT  11, 1, 'EN SERVEI',      'true', 'true'
    FROM DUAL
    UNION
    SELECT  12, 1, 'PROVISIONAL',    'true', 'true'
    FROM DUAL
    UNION
    SELECT  13, 1, 'OBRES',          'true', 'true'
    FROM DUAL
    UNION
    SELECT  21, 2, 'PLANIFICAT',     'false', 'true'
    FROM DUAL;


-- CLAVEGUERAM 

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.VALUE_STATE_TYPE AS
	
    SELECT 0           	      AS id,
           0                  AS state,
    	     'BAIXA'           	AS name,
           'false'            AS is_operative,
           'false'            AS is_doable
    FROM DUAL
    UNION
    SELECT  10, 1, 'PENDENT',        'true', 'true'
    FROM DUAL
    UNION
    SELECT  11, 1, 'EN SERVEI',      'true', 'true'
    FROM DUAL
    UNION
    SELECT  21, 2, 'PLANIFICAT',     'false', 'true'
    FROM DUAL;
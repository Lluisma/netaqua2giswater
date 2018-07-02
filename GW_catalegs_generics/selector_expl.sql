

-- ABASTAMENT

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.SELECTOR_EXPL AS
	
    SELECT 1           	   		AS id,
           1                	AS expl_id,
    	   'amsaadmin'  			AS cur_user
    FROM DUAL
    UNION
    SELECT  2, 2, 'amsaadmin'
    FROM DUAL
    UNION
    SELECT  3, 3, 'amsaadmin'
    FROM DUAL
    UNION
    SELECT  4, 1, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  5, 2, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  6, 3, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  7, 1, 'amsainve'
    FROM DUAL
    UNION
    SELECT  8, 2, 'amsainve'
    FROM DUAL
    UNION
    SELECT  9, 3, 'amsainve'
    FROM DUAL;



-- CLAVEGUERAM

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.SELECTOR_EXPL AS
	
    SELECT 1           	   		AS id,
           1                	AS expl_id,
    	   'amsaadmin'  		AS cur_user
    FROM DUAL
    UNION
    SELECT  2, 1, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  3, 1, 'amsainve'
    FROM DUAL;
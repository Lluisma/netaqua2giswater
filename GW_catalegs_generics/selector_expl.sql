

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
    FROM DUAL;



-- CLAVEGUERAM

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.SELECTOR_EXPL AS
	
    SELECT 1           	   		AS id,
           1                	AS expl_id,
    	   'amsaadmin'  		AS cur_user
    FROM DUAL
    UNION
    SELECT  2, 1, 'bgeoadmin'
    FROM DUAL;
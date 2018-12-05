

-- ABASTAMENT

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.SELECTOR_EXPL AS
	
    SELECT 1           	   		AS id,
           1                	AS expl_id,
    	   'amsaadmin'  			AS cur_user
    FROM DUAL
    UNION
    SELECT  2, 1, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  3, 1, 'amsainve'
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
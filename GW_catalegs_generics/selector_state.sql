
CREATE OR REPLACE VIEW SELECTOR_STATE AS
	
    SELECT 1           	   		AS id,
           1                	AS state_id,
    	   'amsaadmin'  		AS cur_user
    FROM DUAL
    UNION
    SELECT  2, 0, 'amsaadmin'
    FROM DUAL
    UNION
    SELECT  3, 1, 'bgeoadmin'
    FROM DUAL
    UNION
    SELECT  4, 0, 'bgeoadmin'
    FROM DUAL;


CREATE OR REPLACE VIEW VALUE_PRIORITY AS

  	SELECT 'HIGH'          AS id,
    	     null            AS observ
    FROM DUAL
    UNION
    SELECT 'NORMAL'        AS id,
           null            AS observ
    FROM   DUAL
    UNION
    SELECT 'LOW'           AS id,
           null            AS observ
    FROM   DUAL;

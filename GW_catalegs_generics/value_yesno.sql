
CREATE OR REPLACE VIEW VALUE_YESNO AS

  	SELECT 'NO'            AS id,
           null            AS observ
    FROM DUAL
    UNION
    SELECT 'SI'            AS id,
           null            AS observ
    FROM   DUAL;


CREATE OR REPLACE VIEW VALUE_VERIFIED AS

  	SELECT 'NO_VERIFICAT'  AS id,
           null            AS observ
    FROM DUAL
    UNION
    SELECT 'VERIFICAT'     AS id,
           null            AS observ
    FROM   DUAL;

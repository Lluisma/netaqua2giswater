
CREATE OR REPLACE VIEW VALUE_REVIEW_STATUS AS

  	SELECT 0               AS id,
    	   'SENSE CANVIS'  AS descript,
           null            AS name
    FROM   DUAL
    UNION
    SELECT 1, 'NOU ELEMENT', null FROM DUAL
    UNION
    SELECT 2, 'CANVI DE GEOMETRIA I DADES', null FROM DUAL
    UNION
    SELECT 3, 'CANVI DE DADES', null FROM DUAL;


CREATE OR REPLACE VIEW ELEMENT_TYPE AS 

	SELECT  'TAPA'			    AS "id",
        	'true'				  AS active,
          'true'		      AS code_autofill,
          null		        AS descript,
          null		        AS link_path
	FROM DUAL
	UNION
	SELECT	'GRAO', 'true', 'true', null, null
	FROM DUAL;

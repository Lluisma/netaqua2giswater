
CREATE OR REPLACE VIEW ELEMENT_TYPE AS 

	SELECT  'AIXETA'	    id,
          'true'			  active,
          'true'		    code_autofill,
          null		      descript,
          null		      link_path
	FROM DUAL
	UNION
	SELECT	'ARQFONT','true','true',null,null
	FROM DUAL
	UNION
	SELECT	'ARQUETA','true','true',null,null
	FROM DUAL
	UNION
	SELECT	'PORTELLA','true','true',null,null
	FROM DUAL;

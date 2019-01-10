
CREATE OR REPLACE VIEW ELEMENT_TYPE AS 

	SELECT  'AIXETA'	    id,
          'true'			  active,
          'true'		    code_autofill,
          'Aixeta'      descript,
          null		      link_path
	FROM DUAL
	UNION
	SELECT	'ARQFONT','true','true','Arqueta Font',null
	FROM DUAL
	UNION
	SELECT	'ARQUETA','true','true','Arqueta',null
	FROM DUAL
	UNION
	SELECT	'PORTELLA','true','true','Portella',null
	FROM DUAL;

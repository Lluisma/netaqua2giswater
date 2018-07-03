
CREATE OR REPLACE VIEW CONNEC_TYPE AS 

	SELECT  'FONT_ORN'	            AS "id",
		    	'FOUNTAIN'	            AS "type",
			    'man_fountain'	        AS man_table,
			    'true'			            AS active,
			    'true'		              AS code_autofill,
			    'Font Ornamental'		    AS descript,
			    null		                AS link_path
	FROM DUAL
	UNION
	SELECT	'BOCA_REG',  'GREENTAP', 'man_greentap', 'true', 'true',  'Boca de reg',     null
	FROM DUAL
	UNION
	SELECT	'PUNT_CAR',  'GREENTAP', 'man_greentap', 'true', 'true',  'Punt de càrrega', null
	FROM DUAL
	UNION
	SELECT	'FONT',      'TAP',      'man_tap',      'true', 'false', 'Font',            null
	FROM DUAL
  UNION
	SELECT	'ABEURADOR', 'TAP',      'man_tap',      'true', 'false', 'Abeurador',       null
	FROM DUAL
	UNION
	SELECT	'ESCOMESA',  'WJOIN',    'man_wjoinp',   'true', 'false', 'Escomesa',        null
	FROM DUAL;

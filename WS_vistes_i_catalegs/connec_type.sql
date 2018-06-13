
CREATE OR REPLACE VIEW CONNEC_TYPE AS 

	SELECT  'FONT_ORN'	    id,
		    	'FOUNTAIN'	    type,
			    'man_fountain'	man_table,
			    'true'			active,
			    'true'		    code_autofill,
			    null		    descript,
			    null		    link_path
	FROM DUAL
	UNION
	SELECT	'BOCA_REG',  'GREENTAP', 'man_greentap', 'true', 'true',  null, null
	FROM DUAL
	UNION
	SELECT	'PUNT_CAR',  'GREENTAP', 'man_greentap', 'true', 'true',  null, null
	FROM DUAL
	UNION
	SELECT	'FONT',      'TAP',      'man_tap',      'true', 'false', null, null
	FROM DUAL
  UNION
	SELECT	'ABEURADOR', 'TAP',      'man_tap',      'true', 'false', null, null
	FROM DUAL
	UNION
	SELECT	'ESCOMESA',  'WJOIN',    'man_wjoinp',   'true', 'false', null, null
	FROM DUAL;

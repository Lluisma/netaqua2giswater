

-- NA_FONT.CONNEXIO			CAT2_T_FONT_CONN
-- NA_FOOR.CONNEXIO			CAT2_T_FOOR_CONN
-- NA_TRAM.ID_SUBXARXA	'P' / 'S'


CREATE OR REPLACE VIEW MAN_TYPE_CATEGORY AS 

	SELECT	ROWNUM			id,
			T1.*
	FROM (

		SELECT  'P' 		      	category_type,
			     	'ARC' 			    feature_type,
				    'PIPE'			    featurecat_id,
				    'Principal'     observ
		FROM 	DUAL
		UNION
		SELECT  'S', 'ARC', 'PIPE', 'Secundària'
		FROM 	DUAL

		UNION

		SELECT ID_FONT_CONN, 'CONNEC', 'TAP',      TRIM(SUBSTR(FONT_CONN, INSTR(FONT_CONN,' - ')+3))
		FROM   NA_MATARO.CAT2_T_FONT_CONN

		UNION

		SELECT ID_FOOR_CONN, 'CONNEC', 'FOUNTAIN', TRIM(SUBSTR(FOOR_CONN, INSTR(FOOR_CONN,' - ')+3))
		FROM   NA_MATARO.CAT2_T_FOOR_CONN

		ORDER BY 2, 3, 1

	) T1;
	

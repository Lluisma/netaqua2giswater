
-- CL_NODE.NODE_FUN		'NR'
-- CL_EMBORNAL.TIPUS  'D', 'S', 'X'
-- CL_REIXA.TIPUS     'D', 'S', 'X'

CREATE OR REPLACE VIEW MAN_TYPE_FUNCTION AS 

	SELECT	ROWNUM			          id,
          T1.*
	FROM (

		SELECT 	'A_PRESSIO'		      function_type,
            'ARC'		  		      feature_type,
            'CONDUIT'  		      featurecat_id,
            'Xarxa a Pressió'	  observ
		FROM    DUAL

		UNION
		
    SELECT  'RIERA',  'NODE', 'JUNCTION', 'Node Riera'
		FROM 	DUAL
    UNION
    SELECT  'CUNETA', 'NODE', 'JUNCTION', 'Node Cuneta'
		FROM 	DUAL

		UNION
		
    SELECT 'D', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'Directe'
		FROM 	DUAL
    UNION
    SELECT 'S', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'Sifònic'
		FROM 	DUAL
    UNION
    SELECT 'X', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'Desconegut'
		FROM 	DUAL
    
		ORDER BY 2, 3, 1

	) T1;
	

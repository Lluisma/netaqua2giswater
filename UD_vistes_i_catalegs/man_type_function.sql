
-- CL_NODE.NODE_FUN		'NR'
-- CL_EMBORNAL.TIPUS  'D', 'S', 'X'
-- CL_REIXA.TIPUS     'D', 'S', 'X'

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.MAN_TYPE_FUNCTION AS 

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
		
    SELECT 'D', 'GULLY', 'GULLY', 'Directe'
		FROM 	DUAL
    UNION
    SELECT 'S', 'GULLY', 'GULLY', 'Sifònic'
		FROM 	DUAL
    UNION
    SELECT 'X', 'GULLY', 'GULLY', 'Desconegut'
		FROM 	DUAL
    
		ORDER BY 2, 3, 1

	) T1;
	

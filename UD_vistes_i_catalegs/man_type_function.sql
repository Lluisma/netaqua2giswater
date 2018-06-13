
-- NA_NODE.NODE_FUN		'NR'

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

		ORDER BY 2, 3, 1

	) T1;
	

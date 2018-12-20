

-- CL_CLAVEGUERO.NUM_CONN     CAT2_T_SIMPLE_MULTIPLE
-- CL_NODE.P_CRITIC     			'NR'
-- CL_TRAM.ID_SUBXARXA	      'P*' / 'S*' / 'A*'
-- CL_EMBORNAL.TIPUS          'B', 'BR', 'R', 'X'
-- CL_REIXA.TIPUS             'BR', 'R', 'X'


CREATE OR REPLACE VIEW MAN_TYPE_CATEGORY AS 

	SELECT	ROWNUM			id,
			T1.*
	FROM (

		SELECT  'P' 		      	                        category_type,
			     	'ARC'      	                            feature_type,
				    null                           	      	featurecat_id,
				    'Principal'                             observ
		FROM 	DUAL
		UNION
		SELECT  'S', 'ARC', null,   'Secund�ria'
		FROM 	DUAL
		UNION
		SELECT  'A', 'ARC', 'CONDUIT', 'Xarxa en Alta'
		FROM 	DUAL
    
		UNION

		SELECT ID_SM, 'CONNEC', 'CONNEC', INITCAP(ID_SM_DESCR)
		FROM   NS_MATARO.CAT2_SIMPLE_MULTIPLE

		UNION
		
    SELECT  'P_CRITIC',  'NODE', 'CHAMBER' || chr(38) || 'MANHOLE' || chr(38) || 'NETINIT' || chr(38) || 'OUTFALL', 'Punt cr�tic'
		FROM 	DUAL
    
    UNION
    
    SELECT 'B', 'GULLY', 'EMBORNAL', 'B�stia'
    FROM DUAL
    UNION
    SELECT 'BR', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'B�stia Reixa'
    FROM DUAL
    UNION
    SELECT 'R', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'Reixa'
    FROM DUAL
    UNION
    SELECT 'X', 'GULLY', 'EMBORNAL' || chr(38) || 'REIXA', 'Desconegut'
    FROM DUAL
       
		ORDER BY 2, 3, 1

	) T1;
	


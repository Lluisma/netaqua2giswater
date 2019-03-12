

-- CL_CLAVEGUERO.NUM_CONN     CAT2_T_SIMPLE_MULTIPLE
-- CL_NODE.P_CRITIC     			'NR'
-- CL_TRAM.ID_SUBXARXA	      'P*' / 'S*' / 'A*'
-- CL_EMBORNAL.TIPUS          'B', 'BR', 'R', 'X'
-- CL_REIXA.TIPUS             'BR', 'R', 'X'


CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.MAN_TYPE_CATEGORY AS 

	SELECT	ROWNUM			id,
			T1.*
	FROM (

		SELECT  'P' 		      	                        category_type,
			     	'ARC'      	                            feature_type,
				    null                           	      	featurecat_id,
				    'Principal'                             observ
		FROM 	DUAL
		UNION
		SELECT  'S', 'ARC', null,   'Secundària'
		FROM 	DUAL
		UNION
		SELECT  'A', 'ARC', 'CONDUIT', 'Xarxa en Alta'
		FROM 	DUAL
    
		UNION

		SELECT ID_SM, 'CONNEC', 'CONNEC', INITCAP(ID_SM_DESCR)
		FROM   NS_MATARO.CAT2_SIMPLE_MULTIPLE

		UNION
		
    SELECT  'P_CRITIC',  'NODE', 'CHAMBER' || chr(38) || 'MANHOLE' || chr(38) || 'NETINIT' || chr(38) || 'OUTFALL', 'Punt crític'
		FROM 	DUAL
    
    UNION
    
    SELECT 'B', 'GULLY', 'GULLY', 'Bústia'
    FROM DUAL
    UNION
    SELECT 'BR', 'GULLY', 'GULLY', 'Bústia Reixa'
    FROM DUAL
    UNION
    SELECT 'R', 'GULLY', 'GULLY', 'Reixa'
    FROM DUAL
    UNION
    SELECT 'X', 'GULLY', 'GULLY', 'Desconegut'
    FROM DUAL
       
		ORDER BY 2, 3, 1

	) T1;
	


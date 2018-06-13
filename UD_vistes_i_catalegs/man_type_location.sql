

-- CL_V_CLAVEGUERO.TIPUS_CONN			CAT2_T_CLAVEGUERO_TIPUS_CONNEXIO
-- CL_NODE.NODE_FUN               'IC' / 'NC'

CREATE OR REPLACE VIEW MAN_TYPE_LOCATION AS 

	SELECT	ROWNUM			      id,
			T1.*
	FROM (

		SELECT  REPLACE(UPPER(ID_CLAVTIPCON),' ','_')	  location_type,
            'CONNEC'				                        feature_type,
            'CONNEC'		                            featurecat_id,
            INITCAP(ID_CLAVTIPCON)                  observ
		FROM    NS_MATARO.CAT2_CLAVEGUERO_TIPUS_CONNEXIO

    UNION
    
    SELECT  'CONEGUDA', 'NODE', 'NETINIT' || chr(38) || 'JUNCTION', 'Ubicació coneguda'
    FROM DUAL

    UNION
    
    SELECT  REPLACE(REPLACE(ID_TSIT,' ',''),'Í','I'), 
            'ELEMENT', 
            'TAPA', 
            INITCAP(ID_TSIT)
    FROM    NS_MATARO.CAT_POU_TAPA_SITUACIO
        
		ORDER BY 2, 3, 1

	) T1;
	


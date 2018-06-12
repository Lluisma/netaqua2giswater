

-- NA_BINC.UBICACIO		CAT2_T_VENT_SIT
-- NA_VALV.UBICACIO		CAT2_T_VENT_SIT
-- NA_VENT.UBICACIO		CAT2_T_VENT_SIT


CREATE OR REPLACE VIEW MAN_TYPE_LOCATION AS 

	SELECT	ROWNUM			      id,
			T1.*
	FROM (

		SELECT 	ID_ESCO_PORTELLA_SIT			location_type,
            'ELEMENT'				          feature_type,
            'PORTELLA'			          featurecat_id,
            ESCO_PORTELLA_SIT 			  observ
		FROM    NA_MATARO.CAT2_T_ESCO_PORTELLA_SIT

		UNION

		SELECT 	ID_VENT_SIT, 'NODE', 'HYDRANT' || chr(38) || 'VALVE', VENT_SIT
		FROM    NA_MATARO.CAT2_T_VENT_SIT
   
		ORDER BY 2, 3, 1

	) T1;
	



-- NA_DIPO.FUNCIO		CAT2_T_DIPO_FUNCIO
-- NA_VALV.FUNCIO		CAT2_T_VALV_FUNCIO

CREATE OR REPLACE VIEW MAN_TYPE_FUNCTION AS 

	SELECT	ROWNUM			          id,
          T1.*
	FROM (

		SELECT 	ID_DIPO_FUNCIO		  function_type,
            'NODE'				      feature_type,
            'TANK'     		      featurecat_id,
            DESCR_DIPO_FUNCIO	  observ
		FROM    NA_MATARO.CAT2_T_DIPO_FUNCIO

		UNION

		SELECT  ID_VALV_FUNCIO, 'NODE', 'VALVE', INITCAP(ID_VALV_FUNCIO)
		FROM    NA_MATARO.CAT2_T_VALV_FUNCIO
    WHERE   ID_VALV_FUNCIO NOT IN ('-', 'REGULADORA')
   
    UNION   
    
    SELECT 'OBR', 'CONNEC', 'ESCOMESA', 'Obres' FROM DUAL
    UNION
    SELECT 'INC', 'CONNEC', 'ESCOMESA', 'Incendis' FROM DUAL
    UNION
    SELECT 'RAP', 'CONNEC', 'ESCOMESA', 'Reg Ajuntament Parcs' FROM DUAL
    UNION
    SELECT 'RRP', 'CONNEC', 'ESCOMESA', 'Reg Privat' FROM DUAL
    UNION
    SELECT 'FOP', 'CONNEC', 'ESCOMESA', 'Font P�blica' FROM DUAL
    UNION
    SELECT 'RAA', 'CONNEC', 'ESCOMESA', 'Reg Ajuntament Altres' FROM DUAL  

		ORDER BY 2, 3, 1

	) T1;
	

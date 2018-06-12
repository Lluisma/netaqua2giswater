

CREATE OR REPLACE VIEW CAT_MAT_ARC AS

	SELECT 	ID_MATERIAL id,
			MATERIAL    descript,
        	null        link  
	FROM   	NA_MATARO.CAT_T_MATERIAL
	UNION
	SELECT 	ID_MATERIAL id,
			MATERIAL    descript,
        	null        link  
	FROM   	NA_FIGARO.CAT_T_MATERIAL
	UNION  
	SELECT 	ID_MATERIAL id,
			MATERIAL    descript,
        	null        link  
	FROM   	NA_LLISSADEVALL.CAT_T_MATERIAL
	ORDER BY id;

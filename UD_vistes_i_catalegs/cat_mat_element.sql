
CREATE OR REPLACE VIEW CAT_MAT_ELEMENT AS

	SELECT 	SET_ELEMENT_MAT (ID_GMAT)      id,
			    INITCAP(ID_GMAT)               descript,
        	null                           link  
	FROM   	NS_MATARO.CAT_POU_GRAONS_MATERIAL
  
	UNION
	
  SELECT 	SET_ELEMENT_MAT (ID_TMAT)      id,
			    INITCAP(ID_TMAT)               descript,
        	null                           link  
	FROM   	NS_MATARO.CAT_POU_TAPA_MATERIAL
  
	ORDER BY 1;

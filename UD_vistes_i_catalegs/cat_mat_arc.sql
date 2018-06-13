

CREATE OR REPLACE VIEW CAT_MAT_ARC AS

	SELECT 	SET_ARC_MAT( ID_TMAT )     "id",
    			CASE ID_TMAT
            WHEN 'ACER COAR.'  THEN 'Acer Coarrugat'
            WHEN '-'           THEN 'Altres'
            ELSE INITCAP( ID_TMAT )
          END                         descript,
        	null                        "link"
	FROM   	NS_MATARO.CAT_TRAM_MATERIAL

	ORDER BY 1;

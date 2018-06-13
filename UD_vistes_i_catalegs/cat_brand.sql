
CREATE OR REPLACE VIEW CAT_BRAND AS 

  -- REIXA : FABRICANT

	SELECT  CASE 
            WHEN ID_RFAB='-' THEN 'XX'
            ELSE REPLACE( ID_RFAB, 'Á', 'A' )
          END                            AS "id",
	        CASE
            WHEN ID_RFAB='-' THEN 'Marca desconeguda'
            ELSE INITCAP( ID_RFAB )
          END                            AS descript,   
			    null	        		             AS "link"
	FROM	NS_MATARO.CAT_REIXA_FABRICANT
  
	ORDER BY 1;

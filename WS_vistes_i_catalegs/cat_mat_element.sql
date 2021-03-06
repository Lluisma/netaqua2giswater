

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.CAT_MAT_ELEMENT AS

	SELECT 	CASE ID_FONT_ARQUETA_MAT
            WHEN 'HDP' THEN 'HDPE'
            ELSE ID_FONT_ARQUETA_MAT
          END                            id,
			    INITCAP(FONT_ARQUETA_MAT)      descript,
        	null                           link  
	FROM   	NA_MATARO.CAT2_T_FONT_ARQUETA_MAT
  
	UNION
  
	SELECT 	CASE ID_ESCO_PORTELLA_MAT
            WHEN 'HDP' THEN 'HDPE'
            ELSE ID_ESCO_PORTELLA_MAT
          END,
			    TRIM(SUBSTR(ESCO_PORTELLA_MAT, INSTR(ESCO_PORTELLA_MAT,' - ')+3)),
        	null
	FROM   	NA_MATARO.CAT2_T_ESCO_PORTELLA_MAT
  
  UNION
  
  SELECT 'AG', 'Acer Galvanitzat', null FROM DUAL
  UNION
  SELECT 'FD', 'Fosa d�ctic',      null FROM DUAL
  
  
	ORDER BY 1;

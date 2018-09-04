
CREATE OR REPLACE VIEW CAT_BRAND_MODEL AS 

	SELECT 	DISTINCT REPLACE(UPPER(TRIM(SUBSTR(T3.DESCR_VR_MODEL, INSTR(T3.DESCR_VR_MODEL,' - ')+3))),' ','_') id,
    	   	TRIM(SUBSTR(T2.DESCR_VR_MARCA, INSTR(T2.DESCR_VR_MARCA,' - ')+3))                                  catbrand_id, 
       		REPLACE(TRIM(SUBSTR(T3.DESCR_VR_MODEL, INSTR(T3.DESCR_VR_MODEL,' - ')+3)),'_XX',' - ??')           descript, 
       		null                                                                                               link
	FROM   NA_MATARO.NA_V_VALV T1
    	     LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MARCA T2 ON T1.MARCA = T2.ID_VR_MARCA
        	 LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MODEL T3 ON T1.MODEL = T3.ID_VR_MODEL
	WHERE  T1.MODEL IS NOT NULL
	
  UNION
	
  SELECT 	DISTINCT REPLACE(UPPER(TRIM(CAST(T3.ID_COMP_FAB AS VARCHAR2(20)))),' ','_'),
    	   	REPLACE(INITCAP(CAST(T2.ID_COMP_MARCA AS VARCHAR2(10))),' '), 
       		TRIM(CAST(T3.ID_COMP_FAB AS VARCHAR2(20))), 
       		null
	FROM   NA_MATARO.NA_V_COMP T1
    	     LEFT JOIN NA_MATARO.CAT2_T_COMP_MARCA T2 ON T1.MARCA = T2.ID_COMP_MARCA
        	 LEFT JOIN NA_MATARO.CAT2_T_COMP_FAB T3 ON T1.CODI_FAB = T3.ID_COMP_FAB
	WHERE  T1.CODI_FAB IS NOT NULL
  
  UNION
  
  SELECT  REPLACE(UPPER(TRIM(SUBSTR(T1.FONT_TIPUS, INSTR(T1.FONT_TIPUS,' - ')+3))),' ','_'),
          null,
          T1.FONT_TIPUS_MODEL,
          null
  FROM    NA_MATARO.CAT2_T_FONT_TIPUS T1
  WHERE   T1.ID_FONT_TIPUS <> 'MO'
  UNION
  SELECT  REPLACE(UPPER(TRIM(SUBSTR(T1.FONT_TIPUS, INSTR(T1.FONT_TIPUS,' - ')+3))),' ','_'),
          null,
          T1.FONT_TIPUS_MODEL,
          null
  FROM    NA_FIGARO.CAT2_T_FONT_TIPUS T1
  WHERE   T1.ID_FONT_TIPUS <> 'MO'
  UNION
  SELECT  REPLACE(UPPER(TRIM(SUBSTR(T1.FONT_TIPUS, INSTR(T1.FONT_TIPUS,' - ')+3))),' ','_'),
          null,
          T1.FONT_TIPUS_MODEL,
          null
  FROM    NA_LLISSADEVALL.CAT2_T_FONT_TIPUS T1
  WHERE   T1.ID_FONT_TIPUS <> 'MO'
  
  UNION
  
  SELECT  'A', null, 'Alta', null       FROM DUAL
  UNION
  SELECT  'P', null, 'Principal', null  FROM DUAL
  UNION
  SELECT  'S', null, 'Secundària', null FROM DUAL
  
  
	ORDER BY 2, 1;


/* CONSULTA PER MIGRACIÃ“ */

CREATE OR REPLACE VIEW TMP_CAT_BRAND_MODEL AS 

	SELECT 	DISTINCT REPLACE(UPPER(TRIM(SUBSTR(T3.DESCR_VR_MODEL, INSTR(T3.DESCR_VR_MODEL,' - ')+3))),' ','_') id,
    	   	TRIM(SUBSTR(T2.DESCR_VR_MARCA, INSTR(T2.DESCR_VR_MARCA,' - ')+3))                                  catbrand_id, 
          REPLACE(TRIM(SUBSTR(T3.DESCR_VR_MODEL, INSTR(T3.DESCR_VR_MODEL,' - ')+3)),'_XX',' - ??')           descript, 
       		null                                                                                               link,
       		T2.ID_VR_MARCA                                                                                     id_marca_netaqua,
       		T3.ID_VR_MODEL                                                                                     id_model_netaqua
	FROM   NA_MATARO.NA_V_VALV T1
    	     LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MARCA T2 ON T1.MARCA = T2.ID_VR_MARCA
        	 LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MODEL T3 ON T1.MODEL = T3.ID_VR_MODEL
	WHERE  T1.MODEL IS NOT NULL
	UNION
	SELECT 	DISTINCT REPLACE(UPPER(TRIM(CAST(T3.ID_COMP_FAB AS VARCHAR2(20)))),' ','_'),
    	   	REPLACE(INITCAP(CAST(T2.ID_COMP_MARCA AS VARCHAR2(10))),' '), 
       		TRIM(CAST(T3.ID_COMP_FAB AS VARCHAR2(20))), 
       		null,
       		CAST(T2.ID_COMP_MARCA AS VARCHAR2(20)),
       		CAST(T3.ID_COMP_FAB AS VARCHAR2(20))
	FROM   NA_MATARO.NA_V_COMP T1
    	     LEFT JOIN NA_MATARO.CAT2_T_COMP_MARCA T2 ON T1.MARCA = T2.ID_COMP_MARCA
        	 LEFT JOIN NA_MATARO.CAT2_T_COMP_FAB T3 ON T1.CODI_FAB = T3.ID_COMP_FAB
	WHERE  T1.CODI_FAB IS NOT NULL
	ORDER BY CATBRAND_ID, ID;


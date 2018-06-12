
CREATE OR REPLACE VIEW TMP_CAT_ELEMENT_ARQFONT AS

	SELECT DISTINCT 
	       CASE
	         WHEN ARQ_SECC='C' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_DIAM
	         WHEN ARQ_SECC='Q' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_AMP || 'x' || ARQ_ALT
	         WHEN ARQ_SECC='R' THEN ARQ_MATE || '_' || ARQ_SECC || '_' || ARQ_AMP || 'x' || ARQ_ALT
	         ELSE ARQ_MATE || '_' || 'X'
	        END                             id,
	        'ARQFONT'                       elementtype_id,
	        ARQ_MATE                        matcat_id,
	        --Camp GEOMETRY : Un descriptor de la geometria del element 
	        CASE
	         WHEN ARQ_SECC='C' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_SECC) || ' ' || ARQ_DIAM
	         WHEN ARQ_SECC='Q' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_SECC) || ' ' || ARQ_AMP || 'x' || ARQ_ALT
	         WHEN ARQ_SECC='R' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_SECC) || ' ' || ARQ_AMP || 'x' || ARQ_ALT
	         ELSE 'Arqueta Secció desconeguda ' || ARQ_SECC  
	        END                             geometry,
	        CASE
	         WHEN ARQ_SECC='C' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_MAT) || ' - ' || INITCAP(FONT_ARQUETA_SECC) || ' (' || ARQ_DIAM || ' cm)'
	         WHEN ARQ_SECC='Q' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_MAT) || ' - ' || INITCAP(FONT_ARQUETA_SECC) || ' (' || ARQ_AMP || 'x' || ARQ_ALT || ' cm)'
	         WHEN ARQ_SECC='R' THEN 'Arqueta ' || INITCAP(FONT_ARQUETA_MAT) || ' - ' || INITCAP(FONT_ARQUETA_SECC) || ' (' || ARQ_AMP || 'x' || ARQ_ALT || ' cm)'
	         ELSE 'Arqueta ' || INITCAP(FONT_ARQUETA_MAT) || ' Secció desconeguda ' || ARQ_SECC  
	        END                             descript,
	        null                            link,
	        null                            brand,
	        null                            type,
	        null                            model,
	        null                            svg,
	        'true'                          active
	FROM   NA_MATARO.NA_V_FONT T1
	         LEFT JOIN NA_MATARO.CAT2_T_FONT_ARQUETA_MAT T2 ON T1.ARQ_MATE = T2.ID_FONT_ARQUETA_MAT
	         LEFT JOIN NA_MATARO.CAT2_T_FONT_ARQUETA_SECC T3 ON T1.ARQ_SECC = T3.ID_FONT_ARQUETA_SECC
	ORDER BY 1;


CREATE OR REPLACE VIEW TMP_CAT_ELEMENT_ARQUETA AS
	SELECT DISTINCT 
	       ID_VALV_ARQUETA                  id,
	       'ARQUETA'                        elementtype_id,
	       CASE 
	         WHEN ID_VALV_ARQUETA = 'X-XX' THEN null
	         ELSE 'FO'
	       END                              matcat_id,
	        --Camp GEOMETRY : Un descriptor de la geometria del element
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           ELSE 'Arqueta'
	       END                             geometry,
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN ID_VALV_ARQUETA = 'X-XX' THEN 'Arqueta - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           ELSE 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
	       END                             descript,
	       null                            link,
	       VALVULA_ARQUETA_MARCA           brand,
	       null                            type,
	       null                            model,
	       null                            svg,
	       'true'                          active
	FROM   NA_MATARO.CAT2_T_VALV_ARQUETA T1
	UNION
	SELECT DISTINCT 
	       ID_VALV_ARQUETA                  id,
	       'ARQUETA'                        elementtype_id,
	       CASE 
	         WHEN ID_VALV_ARQUETA = 'X-XX' THEN null
	         ELSE 'FO'
	       END                              matcat_id,
	       --Camp GEOMETRY : Un descriptor de la geometria del element
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           ELSE 'Arqueta'
	       END                             geometry,
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN ID_VALV_ARQUETA = 'X-XX' THEN 'Arqueta - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           ELSE 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
	       END                             descript,
	       null                            link,
	       VALVULA_ARQUETA_MARCA           brand,
	       null                            type,
	       null                            model,
	       null                            svg,
	       'true'                          active
	FROM   NA_FIGARO.CAT2_T_VALV_ARQUETA T1
	UNION
	SELECT DISTINCT 
	       ID_VALV_ARQUETA                  id,
	       'ARQUETA'                        elementtype_id,
	       CASE 
	         WHEN ID_VALV_ARQUETA = 'X-XX' THEN null
	         ELSE 'FO'
	       END                              matcat_id,
	       --Camp GEOMETRY : Un descriptor de la geometria del element
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
             WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
             ELSE 'Arqueta'
	       END                             geometry,
	       CASE
	         WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='R' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN SUBSTR(ID_VALV_ARQUETA,1,1)='Q' THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           WHEN ID_VALV_ARQUETA = 'X-XX' THEN 'Arqueta - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
           ELSE 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
	       END                             descript,
	       null                            link,
	       VALVULA_ARQUETA_MARCA           brand,
	       null                            type,
	       null                            model,
	       null                            svg,
	       'true'                          active
	FROM   NA_LLISSADEVALL.CAT2_T_VALV_ARQUETA T1
	UNION
	SELECT DISTINCT 
	       CASE 
	         WHEN ARQUETA = 'X-XX' AND MAT_TAPA IS NULL THEN 'X-XX'
	         WHEN ARQUETA = 'X-XX' AND MAT_TAPA = 'XX' THEN 'X-XX'
	         WHEN ARQUETA = 'X-XX' THEN 'X-' || MAT_TAPA
	         WHEN MAT_TAPA IS NULL THEN ARQUETA
	         WHEN MAT_TAPA = 'FO'  THEN ARQUETA
	         ELSE ARQUETA || '_' || MAT_TAPA
	       END,
	       'ARQUETA',
	       CASE 
	         WHEN ARQUETA = 'X-XX' AND MAT_TAPA IS NULL THEN null
           WHEN MAT_TAPA = 'XX' THEN null
           WHEN MAT_TAPA IS NULL THEN 'FO'
	         ELSE MAT_TAPA
	       END,
	       CASE
	         WHEN SUBSTR(VALVULA_ARQUETA,1,1)='Q' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
	         WHEN SUBSTR(VALVULA_ARQUETA,1,1)='R' THEN 'Arqueta ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3))
	         ELSE 'Arqueta'
	       END,
	       CASE
	         WHEN MAT_TAPA IS NOT NULL AND MAT_TAPA <> 'XX' THEN 'Arqueta ' || TRIM(SUBSTR(ESCO_PORTELLA_MAT, INSTR(ESCO_PORTELLA_MAT,' - ')+3)) || ' - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3)) 
	         WHEN MAT_TAPA IS NULL AND ARQUETA = 'X-XX' THEN 'Arqueta - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3)) 
	         WHEN MAT_TAPA IS NULL THEN 'Arqueta Foneria - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3)) 
	         ELSE  'Arqueta - ' || TRIM(SUBSTR(VALVULA_ARQUETA, INSTR(VALVULA_ARQUETA,' - ')+3)) 
	       END,
	       null,
	       VALVULA_ARQUETA_MARCA,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_MATARO.NA_V_VDES T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_ARQUETA T2 ON T1.ARQUETA = T2.ID_VALV_ARQUETA
	         LEFT JOIN NA_MATARO.CAT2_T_ESCO_PORTELLA_MAT T2 ON T1.MAT_TAPA = T2.ID_ESCO_PORTELLA_MAT
	WHERE  ARQUETA IS NOT NULL OR MAT_TAPA IS NOT NULL
	ORDER BY 1;



CREATE OR REPLACE VIEW TMP_CAT_ELEMENT_AIXETA AS

  -- AIXETES NOMÉS DEFINIDES A NA_MATARO

	SELECT DISTINCT 
         CASE
             WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC IS NULL OR AIX_ROSC = 0) THEN 'AIX_XX'
             WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC = .5) THEN 'AIX_XX_1/2'
             WHEN AIXETA IS NULL OR AIXETA = 'AL' THEN 'AIX_XX_' || AIX_ROSC
             WHEN AIX_ROSC IS NULL OR AIX_ROSC = 0 THEN 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3))
             WHEN AIX_ROSC = .5 THEN 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3)) || '_1/2'
             ELSE 'AIX_' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3)) || '_' || AIX_ROSC
         END                                id,
	       'AIXETA'                           elementtype_id,
	       null                               matcat_id,
         'Aixeta'                           geometry,
         CASE
           WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC IS NULL OR AIX_ROSC = 0) THEN 'Aixeta - Altres / Desconegut'
           WHEN (AIXETA IS NULL OR AIXETA = 'AL') AND (AIX_ROSC = .5) THEN 'Aixeta 1/2" - Altres / Desconegut'
           WHEN AIXETA IS NULL OR AIXETA = 'AL' THEN 'Aixeta ' || AIX_ROSC ||  '" - Altres / Desconegut'
           WHEN AIX_ROSC IS NULL OR AIX_ROSC = 0 THEN 'Aixeta - ' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3))
           WHEN AIX_ROSC = .5 THEN 'Aixeta 1/2" - ' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3))
           ELSE 'Aixeta ' || AIX_ROSC || '" - ' || TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3))
         END                                descript,
	       null                               link,
         CASE
           WHEN AIXETA IS NULL OR AIXETA = 'AL' THEN null
	         ELSE INITCAP( TRIM(SUBSTR(T2.FONT_AIXETA, INSTR(T2.FONT_AIXETA,' - ')+3)))
         END                                brand,
	       null                               type,
	       null                               model,
	       null                               svg,
	       'true'                             active
	FROM   NA_MATARO.NA_V_FONT T1
           LEFT JOIN NA_MATARO.CAT2_T_FONT_AIXETA T2 ON T1.AIXETA = T2.ID_FONT_AIXETA
  ORDER BY 1;
           
           
CREATE OR REPLACE VIEW CAT_ELEMENT AS

    SELECT * FROM TMP_CAT_ELEMENT_AIXETA
    UNION
    SELECT * FROM TMP_CAT_ELEMENT_ARQFONT
    UNION
  	SELECT * FROM TMP_CAT_ELEMENT_ARQUETA
  	UNION
    -- ÉS UNA TAULA FIXA!!
  	SELECT * FROM TMP_CAT_ELEMENT_PORTELLA
  	ORDER BY 1;

/*

CREATE OR REPLACE VIEW REVI_CAT_ELEMENT AS
  SELECT ID_BINC, TRAPA, 'MATARO_BINC' ORIGEN
  FROM NA_MATARO.NA_V_BINC
  WHERE TRAPA NOT IN (SELECT ID_VALV_ARQUETA FROM NA_MATARO.CAT2_T_VALV_ARQUETA)
  UNION  
  SELECT ID_VENT, TRAPA, 'MATARO_VENT' ORIGEN
  FROM NA_MATARO.NA_V_VENT
  WHERE TRAPA NOT IN (SELECT ID_VALV_ARQUETA FROM NA_MATARO.CAT2_T_VALV_ARQUETA)
  UNION  
  SELECT ID_VDES, ARQUETA, 'MATARO_VDES'
  FROM NA_MATARO.NA_V_VDES
  WHERE ARQUETA NOT IN (SELECT ID_VALV_ARQUETA FROM NA_MATARO.CAT2_T_VALV_ARQUETA)
  UNION  
  SELECT ID_VDES, ARQUETA, 'FIGARO_VDES'
  FROM NA_FIGARO.NA_V_VDES
  WHERE ARQUETA NOT IN (SELECT ID_VALV_ARQUETA FROM NA_FIGARO.CAT2_T_VALV_ARQUETA)
  UNION
  SELECT ID_VDES, ARQUETA, 'LLISSA_VDES'
  FROM NA_LLISSADEVALL.NA_V_VDES
  WHERE ARQUETA NOT IN (SELECT ID_VALV_ARQUETA FROM NA_LLISSADEVALL.CAT2_T_VALV_ARQUETA);

CREATE OR REPLACE VIEW REVI_CAT_ELEMENT_B AS
  SELECT ID_FONT, CODI_LAB, ARQ2_SECC, ARQ2_DIAM, ARQ2_AMP, ARQ2_ALT
  FROM   NA_MATARO.NA_V_FONT
  WHERE  (ARQ_DIAM > 0 AND (ARQ_AMP >0 OR ARQ_ALT >0))
     OR  (ARQ2_DIAM > 0 AND (ARQ2_AMP >0 OR ARQ2_ALT >0));

*/
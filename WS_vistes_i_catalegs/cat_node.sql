

CREATE OR REPLACE VIEW TMP_CAT_NODE_HIDRANT AS 

	SELECT DISTINCT
	      'HIDR_' || TIPUS || '_' || DIAMETRE   ID,
	       'HIDRANT'                            NODETYPE_ID,
	       null                                 MATCAT_ID,
	       null                                 PNOM,
	       TO_CHAR(DIAMETRE)                    DNOM,
	       DIAMETRE                             DINT,
	       null                                 DEXT,
	       null                                 SHAPE,
	       'Hidrant ' || SUBSTR(T2.BOCAINC_TIPUS, 4) || ' Ø' || DIAMETRE || ' mm'  DESCRIPT,
	       null                                 LINK,
	       T2.BOCAINC_TIPUS_MARCA               BRAND,
	       null                                 MODEL,
	       null                                 SVG,
	       null                                 ESTIMATED_DEPTH,
	       null                                 COST_UNIT,
	       null                                 COST,
	       'true'                               ACTIVE
	FROM   NA_MATARO.NA_V_BINC T1
	         LEFT JOIN NA_MATARO.CAT2_T_BINC_TIPUS T2 ON T1.TIPUS = T2.ID_BINC_TIPUS
	UNION
	SELECT DISTINCT
	      'HIDR_' || TIPUS || '_' || DIAMETRE   ID,
	       'HIDRANT'                            NODETYPE_ID,
	       null                                 MATCAT_ID,
	       null                                 PNOM,
	       TO_CHAR(DIAMETRE)                    DNOM,
	       DIAMETRE                             DINT,
	       null                                 DEXT,
	       null                                 SHAPE,
	       'Hidrant ' || SUBSTR(T2.BOCAINC_TIPUS, 4) || ' Ø' || DIAMETRE || ' mm'  DESCRIPT,
		   null                                 LINK,
	       T2.BOCAINC_TIPUS_MARCA               BRAND,
	       null                                 MODEL,
	       null                                 SVG,
	       null                                 ESTIMATED_DEPTH,
	       null                                 COST_UNIT,
	       null                                 COST,
	       'true'                               ACTIVE
	FROM   NA_FIGARO.NA_V_BINC T1
	         LEFT JOIN NA_FIGARO.CAT2_T_BINC_TIPUS T2 ON T1.TIPUS = T2.ID_BINC_TIPUS
	UNION
	SELECT DISTINCT
	      'HIDR_' || TIPUS || '_' || DIAMETRE   ID,
	       'HIDRANT'                            NODETYPE_ID,
	       null                                 MATCAT_ID,
	       null                                 PNOM,
	       TO_CHAR(DIAMETRE)                    DNOM,
	       DIAMETRE                             DINT,
	       null                                 DEXT,
	       null                                 SHAPE,
	       'Hidrant ' || SUBSTR(T2.BOCAINC_TIPUS, 4) || ' Ø' || DIAMETRE || ' mm'  DESCRIPT,
	       null                                 LINK,
	       T2.BOCAINC_TIPUS_MARCA               BRAND,
	       null                                 MODEL,
	       null                                 SVG,
	       null                                 ESTIMATED_DEPTH,
	       null                                 COST_UNIT,
	       null                                 COST,
	       'true'                               ACTIVE
	FROM   NA_LLISSADEVALL.NA_V_BINC T1
	         LEFT JOIN NA_LLISSADEVALL.CAT2_T_BINC_TIPUS T2 ON T1.TIPUS = T2.ID_BINC_TIPUS
	ORDER BY 1;



/*
											TIPUS				CATÃ€LEG

A - Antiga derivaciÃ³ 	Antiga derivaciÃ³ 	> UniÃ³				Antiga derivaciÃ³
C - CollarÃ­ / TC		CollarÃ­ / TC		> DerivaciÃ³ 		CollarÃ­ / Toma en cÃ rrega
X - Creuament 			Creu				> Creu
D - DerivaciÃ³ 			DerivaciÃ³			> DerivaciÃ³ 		Te abraÃ§adera
V - DerivaciÃ³ virtual 	DerivaciÃ³ virtual	> DerivaciÃ³ 		DerivaciÃ³ virtual
- - Desconegut 			Node GIS (Desc.)	> UniÃ³ 				UniÃ³ virtual
 I - Inici / Final 		Inici/Final			> Inici 
S - Separador de Tram 	Separador de Tram 	> UniÃ³ 				Separador
						Tap					> Tap
T - Te 					Te 					> DerivaciÃ³ 		Te
U - UniÃ³ de Trams		UniÃ³ de Trams		> UniÃ³


Antiga derivaci		> UNIO 				UNIO_ANTIGADER		Antiga derivaciÃ³
UniÃ³ de Trams		> UNIO				UNIO_TRAM			UniÃ³ de tram
Separador de Tram 	> UNIO				UNIO_SEP 			Separador de material
Node GIS (Desc.)	> UNIO 				UNIO_VIRTUAL		UniÃ³ virtual / Desconegut

CollarÃ­ / TC		> DERIVACIO 		DERI_COLLARI		CollarÃ­ / Toma en cÃ rrega
DerivaciÃ³			> DERIVACIO 		DERI_ABRA			Te abraÃ§adera
DerivaciÃ³ virtual	> DERIVACIO 		DERI_VIRTUAL		DerivaciÃ³ virtual
Te 					> DERIVACIO 		DERI_TE				Te

Creu				> CREUAMENT 		CREU_XX

Node GIS (Desc.)	> INICI_FI			INIFI_XX

Tap					> TAP 				TAP_XX

*/

CREATE OR REPLACE VIEW TMP_CAT_NODE_ALTRES AS 

	SELECT 'UNIO_ANTIGADER'              ID,
	       'UNIO'                     NODETYPE_ID,
	       null                       MATCAT_ID,
	       null                       PNOM,
	       null                       DNOM,
	       null                       DINT,
	       null                       DEXT,
	       null                       SHAPE,
	       'Unió - Antiga derivació'  DESCRIPT,
	       null                       LINK,
	       null                       BRAND,
	       null                       MODEL,
	       null                       SVG,
	       null                       ESTIMATED_DEPTH,
	       null                       COST_UNIT,
	       null                       COST,
	       'true'                     ACTIVE
	FROM DUAL
	UNION
	SELECT 'UNIO_TRAM', 'UNIO', null, null, null, null, null, null,
	       'Unió - Unió de tram', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'UNIO_SEP', 'UNIO', null, null, null, null, null, null,
	       'Unió - Separador de material', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'UNIO_VIRTUAL', 'UNIO', null, null, null, null, null, null,
	       'Unió - Unió virtual / Desconegut', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'DERI_COLLARI', 'DERIVACIO', null, null, null, null, null, null,
	       'Derivació - Collarí / Tram en cÃ rrega', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'DERI_ABRA', 'DERIVACIO', null, null, null, null, null, null,
	       'Derivació - Te abraçadera', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'DERI_VIRTUAL', 'DERIVACIO', null, null, null, null, null, null,
	       'Derivació - Derivació virtual', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNIO
	UNION
	SELECT 'DERI_TE', 'DERIVACIO', null, null, null, null, null, null,
	       'Derivació - Te', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNIO
	UNION
	SELECT 'CREU_XX', 'CREUAMENT', null, null, null, null, null, null,
	       'Creuament', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNIO
	UNION
	SELECT 'INIFI_XX', 'INICI_FI', null, null, null, null, null, null,
	       'Inici / Final', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNIO
	UNION
	SELECT 'TAP_XX', 'TAP', null, null, null, null, null, null,
	       'Tap', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'PCON_XX', 'POU_CONN', null, null, null, null, null, null,
	       'Pou de connexió', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'BOMB_XX', 'BOMBAMENT', null, null, null, null, null, null,
	       'Bombament', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'CAPT_XX', 'CAPTACIO', null, null, null, null, null, null,
	       'Captació', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'DIPO_XX', 'DIPOSIT', null, null, null, null, null, null,
	       'Dipòsit', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'POU_XX', 'POU', null, null, null, null, null, null,
	       'Pou', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	UNION
	SELECT 'REDU_XX', 'REDUCCIO', null, null, null, null, null, null,
	       'Reducció', null, null, null, null, null, null, null, 'true'
	FROM DUAL
	ORDER BY 2, 1;


CREATE OR REPLACE VIEW TMP_CAT_NODE_COMP AS 

	-- FIGARO I LLISSADEVALL NO TENEN INFORMAT EL CAMP DIAMETRE

	SELECT DISTINCT 
	       CASE 
	         WHEN DIAMETRE > 0 THEN UPPER( TRIM('_' FROM REPLACE('COMP' || '_' || DIAMETRE || '_' || MARCA || '_' || CODI_FAB,' ','_')))
	         ELSE UPPER(TRIM('_' FROM REPLACE('COMP' || '_XX_' || MARCA || '_' || CODI_FAB,' ','_')))
	       END ID,
	       'COMPTADOR'                NODETYPE_ID,
	       null                       MATCAT_ID,
	       null                       PNOM, 
         CASE 
	         WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
	         ELSE null
	       END                        DNOM,
	       CASE 
	         WHEN DIAMETRE > 0 THEN DIAMETRE
	         ELSE null
	       END                        DINT,
	       null                       DEXT,
	       null                       SHAPE,
	       CASE 
	         WHEN DIAMETRE > 0 THEN 'Comptador ' || TRIM(INITCAP(MARCA) || ' ' || TRIM(CODI_FAB || ' Ø' || DIAMETRE)) || ' mm'
	         ELSE 'Comptador ' || TRIM(TRIM(INITCAP(MARCA) || ' ' || CODI_FAB) || ' Ø desconegut')
	       END                        DESCRIPT,
	       null                       LINK,
	       INITCAP(MARCA)             BRAND,
	       UPPER(REPLACE(TRIM(CODI_FAB), ' ', '_')) MODEL,
	       null                       SVG,
	       null                       ESTIMATED_DEPTH,
	       null                       COST_UNIT,
	       null                       COST,
	       'true'                     ACTIVE
	FROM   NA_MATARO.NA_V_COMP
	UNION
	SELECT DISTINCT UPPER(TRIM('_' FROM REPLACE('COMP' || '_XX_' || MARCA || '_' || CODI_FAB,' ','_'))),
	       'COMPTADOR',
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'Comptador ' || TRIM(TRIM(INITCAP(MARCA) || ' ' || CODI_FAB) || ' Ø desconegut'),
	       null,
	       INITCAP(MARCA),
	       UPPER(REPLACE(TRIM(CODI_FAB), ' ', '_')),
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_FIGARO.NA_V_COMP
	UNION
	SELECT DISTINCT UPPER(TRIM('_' FROM REPLACE('COMP' || '_XX_' || MARCA || '_' || CODI_FAB,' ','_'))),
	       'COMPTADOR',
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'Comptador ' || TRIM(TRIM(INITCAP(MARCA) || ' ' || CODI_FAB) || ' Ø desconegut'),
	       null,
	       INITCAP(MARCA),
	       UPPER(REPLACE(TRIM(CODI_FAB), ' ', '_')),
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_LLISSADEVALL.NA_V_COMP
	ORDER BY 1;


CREATE OR REPLACE VIEW TMP_CAT_NODE_VENTOSA AS

	SELECT DISTINCT
	       CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	     ELSE 'VENT_' || TIPUS || '_XX'
       	   END                                  ID,
		   'VENTOSA'                            NODETYPE_ID,
		   null                            	    MATCAT_ID,
		   null                                 PNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END             	                    DNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END             	                    DINT,
		   null									DEXT,
		   null                                 SHAPE,
		   CASE
		     WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'Ventosa - No coneguda'
             WHEN DIAMETRE >0 AND TIPUS = 'XX' THEN 'Ventosa Ø' || DIAMETRE || ' mm'
		     WHEN DIAMETRE > 0 THEN 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     ELSE 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø desconegut')  
		   END                                  DESCRIPT,
		   null                                 LINK,
		   T2.VENTOSA_TIPUS_MARCA               BRAND,
		   null                                 MODEL,
		   null                                 SVG,
		   null                                 ESTIMATED_DEPTH,
		   null                                 COST_UNIT,
		   null                                 COST,
		   'true'                               ACTIVE
	FROM   NA_MATARO.NA_V_VENT T1
    	     LEFT JOIN NA_MATARO.CAT2_T_VENT_TIPUS T2 ON T1.TIPUS = T2.ID_VENT_TIPUS
    UNION
    SELECT DISTINCT
	       CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	     ELSE 'VENT_' || TIPUS || '_XX'
       	   END,
		   'VENTOSA',
		   null,
		   null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
		   null,
		   null,
		   CASE
		     WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'Ventosa - No coneguda'
             WHEN DIAMETRE >0 AND TIPUS = 'XX' THEN 'Ventosa Ø' || DIAMETRE || ' mm'
		     WHEN DIAMETRE > 0 THEN 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     ELSE 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø desconegut')  
		   END,
		   null,
		   T2.VENTOSA_TIPUS_MARCA,
		   null,
		   null,
		   null,
		   null,
		   null,
		   'true'
	FROM   NA_FIGARO.NA_V_VENT T1
    	     LEFT JOIN NA_FIGARO.CAT2_T_VENT_TIPUS T2 ON T1.TIPUS = T2.ID_VENT_TIPUS
	UNION
	SELECT DISTINCT
	       CASE 
	         WHEN DIAMETRE > 0 THEN 'VENT_' || TIPUS || '_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'VENT_XX'
       	     ELSE 'VENT_' || TIPUS || '_XX'
       	   END,
		   'VENTOSA',
		   null,
		   null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
		   null,
		   null,
		   CASE
		     WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'XX' THEN 'Ventosa - No coneguda'
             WHEN DIAMETRE >0 AND TIPUS = 'XX' THEN 'Ventosa Ø' || DIAMETRE || ' mm'
		     WHEN DIAMETRE > 0 THEN 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     ELSE 'Ventosa ' ||  TRIM(SUBSTR(T2.VENTOSA_TIPUS, INSTR(T2.VENTOSA_TIPUS,' - ')+3) || ' Ø desconegut')  
		   END,
		   null,
		   T2.VENTOSA_TIPUS_MARCA,
		   null,
		   null,
		   null,
		   null,
		   null,
		   'true'
	FROM   NA_LLISSADEVALL.NA_V_VENT T1
    	     LEFT JOIN NA_LLISSADEVALL.CAT2_T_VENT_TIPUS T2 ON T1.TIPUS = T2.ID_VENT_TIPUS
	ORDER BY 1;


CREATE OR REPLACE VIEW TMP_CAT_NODE_VDESCARREGA AS

	SELECT DISTINCT 
	       CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END                                    ID,
	       'VDESCARREGA'                          NODETYPE_ID,
	       null                                   MATCAT_ID,
	       null                                   PNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END             	                      DNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END             	                      DINT,
	       null                                   DEXT,
	       null                                   SHAPE,
	       CASE
			 WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'X-XX' THEN 'V. de Descàrrega Desconeguda'
             WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
             ELSE 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
	       END                                    DESCRIPT,
	       null                                   LINK,
	       T2.VALVULA_TIPUS_MARCA                 BRAND,
	       null                                   MODEL,
	       null                                   SVG,
	       null                                   ESTIMATED_DEPTH,
	       null                                   COST_UNIT,
	       null                                   COST,
	       'true'                                 ACTIVE
	FROM   NA_MATARO.NA_V_VDES T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	UNION
	SELECT DISTINCT 
	       CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END,
	       'VDESCARREGA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'X-XX' THEN 'V. de Descàrrega Desconeguda'
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
	       END,
	       null,
	       T2.VALVULA_TIPUS_MARCA,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_FIGARO.NA_V_VDES T1
	         LEFT JOIN NA_FIGARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	UNION
	SELECT DISTINCT 
	       CASE 
	         WHEN TIPUS = 'X-XX' AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_XX'
	         WHEN TIPUS = 'X-XX' THEN 'VDES_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VDES_' || TIPUS || '_XX'
	         ELSE 'VDES_' || TIPUS || '_' || DIAMETRE  
	       END,
	       'VDESCARREGA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) AND TIPUS = 'X-XX' THEN 'V. de Descàrrega Desconeguda'
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'V. de Descàrrega ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
	       END,
	       null,
	       T2.VALVULA_TIPUS_MARCA,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_LLISSADEVALL.NA_V_VDES T1
	         LEFT JOIN NA_LLISSADEVALL.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	ORDER BY 1;


CREATE OR REPLACE VIEW TMP_CAT_NODE_VALVULA AS

-- VALVULA.TIPUS+DIAMETRE / VENTOSA.VALVULA+DIAMETREVAL (NOMÃ‰S MATARAÃ“, ELS ALTRES ESTAN EN BLANC...)

	SELECT DISTINCT
	       CASE 
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'VALV_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_' || TIPUS || '_XX'
	         ELSE 'VALV_' || TIPUS || '_' || DIAMETRE  
	       END                                    ID,
	       'VALVULA'                              NODETYPE_ID,
	       null                                   MATCAT_ID,
	       null                                   PNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END             	                      DNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END             	                      DINT,
	       null                                   DEXT,
	       null                                   SHAPE,
	       CASE
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula Desconeguda'
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'Vàlvula Desconeguda Ø' || DIAMETRE || ' mm'
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     END                                  DESCRIPT,
	       null                                   LINK,
	       T2.VALVULA_TIPUS_MARCA                 BRAND,
	       null                                   MODEL,
	       null                                   SVG,
	       null                                   ESTIMATED_DEPTH,
	       null                                   COST_UNIT,
	       null                                   COST,
	       'true'                                 ACTIVE
	FROM   NA_MATARO.NA_V_VALV T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	WHERE  T1.FUNCIO <> 'REGULADORA' OR T1.FUNCIO IS NULL
	UNION
	SELECT DISTINCT
	       CASE 
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'VALV_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_' || TIPUS || '_XX'
	         ELSE 'VALV_' || TIPUS || '_' || DIAMETRE  
	       END,
	       'VALVULA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula Desconeguda'
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'Vàlvula Desconeguda Ø' || DIAMETRE || ' mm'
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     END,
	       null,
	       T2.VALVULA_TIPUS_MARCA,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_FIGARO.NA_V_VALV T1
	         LEFT JOIN NA_FIGARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	WHERE  T1.FUNCIO <> 'REGULADORA' OR T1.FUNCIO IS NULL
	UNION
	SELECT DISTINCT
	       CASE 
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_XX'
	         WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'VALV_XX_' || DIAMETRE
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'VALV_' || TIPUS || '_XX'
	         ELSE 'VALV_' || TIPUS || '_' || DIAMETRE  
	       END,
	       'VALVULA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) AND (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula Desconeguda'
			 WHEN (TIPUS = 'X-XX' OR TIPUS IS NULL) THEN 'Vàlvula Desconeguda Ø' || DIAMETRE || ' mm'
	         WHEN (DIAMETRE = 0 OR DIAMETRE IS NULL) THEN 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETRE || ' mm')
		     END,
	       null,
	       T2.VALVULA_TIPUS_MARCA,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_LLISSADEVALL.NA_V_VALV T1
	         LEFT JOIN NA_LLISSADEVALL.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	WHERE  T1.FUNCIO <> 'REGULADORA' OR T1.FUNCIO IS NULL
	UNION
		SELECT DISTINCT
	       CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
             WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
	       END                                    ID,
	       'VALVULA'                              NODETYPE_ID,
	       null                                   MATCAT_ID,
	       null                                   PNOM,
		   CASE 
		     WHEN DIAMETREVAL > 0 THEN DIAMETREVAL || ' mm'
		     ELSE null
		   END             	                      DNOM,
		   CASE 
		     WHEN DIAMETREVAL > 0 THEN DIAMETREVAL
		     ELSE null
		   END             	                      DINT,
	       null                                   DEXT,
	       null                                   SHAPE,
	       CASE
			 WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (DIAMETREVAL = 0 OR DIAMETREVAL IS NULL) THEN 'Vàlvula Desconeguda'
			 WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'Vàlvula Desconeguda Ø' || DIAMETREVAL || ' mm'
	         WHEN (DIAMETREVAL = 0 OR DIAMETREVAL IS NULL) THEN 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETREVAL || ' mm')
		     END                                  DESCRIPT,
	       null                                   LINK,
	       T2.VALVULA_TIPUS_MARCA                 BRAND,
	       null                                   MODEL,
	       null                                   SVG,
	       null                                   ESTIMATED_DEPTH,
	       null                                   COST_UNIT,
	       null                                   COST,
	       'true'                                 ACTIVE
	FROM   NA_MATARO.NA_V_VENT T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_TIPUS T2 ON T1.VALVULA = T2.ID_VALV_TIPUS
	UNION
		SELECT DISTINCT
	       CASE 
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_XX'
	         WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'VALV_XX_' || T1.DIAMETREVAL
             WHEN T1.VALVULA = 'C-XX' AND (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_C-XX'
	         WHEN (T1.DIAMETREVAL = 0 OR T1.DIAMETREVAL IS NULL) THEN 'VALV_' || T1.VALVULA || '_XX'
	         ELSE 'VALV_' || T1.VALVULA || '_' || T1.DIAMETREVAL  
	       END                                    ID,
	       'VALVULA'                              NODETYPE_ID,
	       null                                   MATCAT_ID,
	       null                                   PNOM,
		   CASE 
		     WHEN DIAMETREVAL > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END             	                      DNOM,
		   CASE 
		     WHEN DIAMETREVAL > 0 THEN DIAMETREVAL
		     ELSE null
		   END             	                      DINT,
	       null                                   DEXT,
	       null                                   SHAPE,
	       CASE
			 WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) AND (DIAMETREVAL = 0 OR DIAMETREVAL IS NULL) THEN 'Vàlvula Desconeguda'
			 WHEN (T1.VALVULA = 'X-XX' OR T1.VALVULA IS NULL) THEN 'Vàlvula Desconeguda Ø' || DIAMETREVAL || ' mm'
	         WHEN (DIAMETREVAL = 0 OR DIAMETREVAL IS NULL) THEN 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø desconegut')
	         ELSE 'Vàlvula ' ||  TRIM(SUBSTR(T2.VALVULA_TIPUS, INSTR(T2.VALVULA_TIPUS,' - ')+3) || ' Ø' || DIAMETREVAL || ' mm')
		     END                                  DESCRIPT,
	       null                                   LINK,
	       T2.VALVULA_TIPUS_MARCA                 BRAND,
	       null                                   MODEL,
	       null                                   SVG,
	       null                                   ESTIMATED_DEPTH,
	       null                                   COST_UNIT,
	       null                                   COST,
	       'true'                                 ACTIVE
	FROM   NA_MATARO.NA_V_BINC T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_TIPUS T2 ON T1.VALVULA = T2.ID_VALV_TIPUS
	ORDER BY 1;


CREATE OR REPLACE VIEW TMP_CAT_NODE_VREGULADORA AS

	-- FIGARO I LLISSA DE VALL NO INFORMEN DE MARCA I MODEL
	SELECT DISTINCT
	       CASE
	         WHEN MARCA IS NULL AND MODEL IS NULL AND DIAMETRE > 0 THEN 'VREG_XX_' || DIAMETRE
	         WHEN MARCA IS NULL AND MODEL IS NULL THEN 'VREG_XX'
	         WHEN MODEL = 'RO' THEN  'VREG_' || T3.ID_VR_MARCA || '_XX_' || DIAMETRE
	         ELSE 'VREG_' || T3.ID_VR_MARCA || '_' || T4.ID_VR_MODEL || '_' || DIAMETRE
	       END                                   ID,
	       'VREGULADORA'                          NODETYPE_ID,
	       null                                   MATCAT_ID,
	       null                                   PNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END             	                      DNOM,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END             	                      DINT,
	       null                                   DEXT,
	       null                                   SHAPE,
	       CASE
	         WHEN DIAMETRE > 0 THEN 'V. Reguladora ' || TRIM(TRIM(SUBSTR(T3.DESCR_VR_MARCA, INSTR(T3.DESCR_VR_MARCA,' - ')+3)) || ' ' || 
	                                TRIM(SUBSTR(T4.DESCR_VR_MODEL, INSTR(T4.DESCR_VR_MODEL,' - ')+3))) || ' Ø' ||  DIAMETRE || ' mm' 
	         WHEN MODEL = 'RO' THEN 'V. Reguladora ' || TRIM(SUBSTR(T3.DESCR_VR_MARCA, INSTR(T3.DESCR_VR_MARCA,' - ')+3)) || ' ' || 
	                                ' Ø' ||  DIAMETRE || ' mm' 
	         ELSE 'V. Reguladora ' || TRIM(TRIM(SUBSTR(T3.DESCR_VR_MARCA, INSTR(T3.DESCR_VR_MARCA,' - ')+3)) || ' ' || 
	                                TRIM(SUBSTR(T4.DESCR_VR_MODEL, INSTR(T4.DESCR_VR_MODEL,' - ')+3))) || ' Diàmetre desconegut' 
	       END                                    DESCRIPT,
	       null                                   LINK,
	       TRIM(SUBSTR(T3.DESCR_VR_MARCA, INSTR(T3.DESCR_VR_MARCA,' - ')+3)) BRAND,
	       REPLACE(UPPER(TRIM(SUBSTR(T4.DESCR_VR_MODEL, INSTR(T4.DESCR_VR_MODEL,' - ')+3))),' ','_') MODEL,
	       null                                   SVG,
	       null                                   ESTIMATED_DEPTH,
	       null                                   COST_UNIT,
	       null                                   COST,
	       'true'                                 ACTIVE
	FROM   NA_MATARO.NA_V_VALV T1
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MARCA T3 ON T1.MARCA = T3.ID_VR_MARCA
	         LEFT JOIN NA_MATARO.CAT2_T_VALV_REGU_MODEL T4 ON T1.MODEL = T4.ID_VR_MODEL
	WHERE  T1.FUNCIO = 'REGULADORA'
	UNION
	SELECT DISTINCT
	       CASE
	       	 WHEN TIPUS='X-XX' AND DIAMETRE = 0 THEN 'VREG_XX'
	         WHEN TIPUS='X-XX' THEN 'VREG_' || DIAMETRE
	         ELSE 'VREG_' || TIPUS || '_' || DIAMETRE
	       END,
	       'VREGULADORA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
	         WHEN DIAMETRE > 0 THEN 'V. Reguladora ' || TRIM(SUBSTR(T2.VALVULA_TIPUS_MARCA, INSTR(T2.VALVULA_TIPUS_MARCA,' - ')+3)) || ' Ø' ||  DIAMETRE || ' mm' 
	         ELSE 'V. Reguladora ' || TRIM(SUBSTR(T2.VALVULA_TIPUS_MARCA, INSTR(T2.VALVULA_TIPUS_MARCA,' - ')+3)) || ' Diàmetre desconegut' 
	       END,
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_FIGARO.NA_V_VALV T1
	         LEFT JOIN NA_FIGARO.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	WHERE  T1.FUNCIO = 'REGULADORA'
	UNION
	SELECT DISTINCT
	       CASE
	         WHEN TIPUS='X-XX' AND DIAMETRE = 0 THEN 'VREG_XX'
	         WHEN TIPUS='X-XX' THEN 'VREG_' || DIAMETRE
	         ELSE 'VREG_' || TIPUS || '_' || DIAMETRE
	       END,
	       'VREGULADORA',
	       null,
	       null,
		   CASE 
		     WHEN DIAMETRE > 0 THEN TO_CHAR(DIAMETRE)
		     ELSE null
		   END,
		   CASE 
		     WHEN DIAMETRE > 0 THEN DIAMETRE
		     ELSE null
		   END,
	       null,
	       null,
	       CASE
	         WHEN DIAMETRE > 0 THEN 'V. Reguladora ' || TRIM(SUBSTR(T2.VALVULA_TIPUS_MARCA, INSTR(T2.VALVULA_TIPUS_MARCA,' - ')+3)) || ' Ø' ||  DIAMETRE || ' mm' 
	         ELSE 'V. Reguladora ' || TRIM(SUBSTR(T2.VALVULA_TIPUS_MARCA, INSTR(T2.VALVULA_TIPUS_MARCA,' - ')+3)) || ' Diàmetre desconegut' 
	       END,
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       null,
	       'true'
	FROM   NA_LLISSADEVALL.NA_V_VALV T1
	         LEFT JOIN NA_LLISSADEVALL.CAT2_T_VALV_TIPUS T2 ON T1.TIPUS = T2.ID_VALV_TIPUS
	WHERE  T1.FUNCIO = 'REGULADORA'
	ORDER BY 1;



CREATE OR REPLACE VIEW CAT_NODE AS

	SELECT * FROM TMP_CAT_NODE_ALTRES
	UNION
	SELECT * FROM TMP_CAT_NODE_COMP
	UNION 
	SELECT * FROM TMP_CAT_NODE_HIDRANT
	UNION 
	SELECT * FROM TMP_CAT_NODE_VALVULA
	UNION 
	SELECT * FROM TMP_CAT_NODE_VDESCARREGA
	UNION 
	SELECT * FROM TMP_CAT_NODE_VENTOSA
	UNION 
	SELECT * FROM TMP_CAT_NODE_VREGULADORA
	ORDER BY 2, 1;
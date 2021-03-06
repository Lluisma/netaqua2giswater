
-- NA_FONT.CONNEXIO			CAT2_T_FONT_CONN
-- NA_FOOR.CONNEXIO			CAT2_T_FOOR_CONN
-- NA_TRAM.ID_SUBXARXA	'P' / 'S'

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.MAN_TYPE_CATEGORY AS 

	SELECT	ROWNUM			id,
			T1.*
	FROM (

		SELECT  'P' 		      	category_type,
			     	'ARC' 			    feature_type,
				    'PIPE'			    featurecat_id,
				    'Principal'     observ
		FROM 	DUAL
		UNION
		SELECT  'S', 'ARC', 'PIPE', 'Secund�ria'
		FROM 	DUAL

		UNION

		SELECT ID_FONT_CONN, 'CONNEC', 'TAP',      TRIM(SUBSTR(FONT_CONN, INSTR(FONT_CONN,' - ')+3))
		FROM   NA_MATARO.CAT2_T_FONT_CONN

		UNION

		SELECT ID_FOOR_CONN, 'CONNEC', 'FOUNTAIN', TRIM(SUBSTR(FOOR_CONN, INSTR(FOOR_CONN,' - ')+3))
		FROM   NA_MATARO.CAT2_T_FOOR_CONN

		ORDER BY 2, 3, 1

	) T1
  
  UNION
		SELECT 10, 'C_ALER', 'ELEMENT', 'SONDA_INUN' || chr(38) || 'DATALOG_IN', 'ALERTA' FROM DUAL
  UNION
		SELECT 11, 'C_APOR', 'ELEMENT', 'CHIDR_EAIG' || chr(38) || 'ELECTROVAL' || chr(38) || 'VALVBOIA' || chr(38) || 'COMPT_EAIG', 'APORTACI�' FROM DUAL
  UNION
		SELECT 12, 'C_ASPI', 'ELEMENT', 'CHIDR_PASP' || chr(38) || 'REIXA' || chr(38) || 'TAP_DESG' || chr(38) || 'FILTRE_BOM', 'ASPIRACI�' FROM DUAL
  UNION
		SELECT 13, 'C_CLOR', 'ELEMENT', 'CIRCUIT_CL' || chr(38) || 'BOMBA_DOSI' || chr(38) || 'ANALITZADOR', 'CLORACI�' FROM DUAL
  UNION
		SELECT 14, 'C_CONT', 'ELEMENT', 'QUADRE_EC' || chr(38) || 'DIFERENCIAL' || chr(38) || 'MAGNETOTER', 'CONTROL' FROM DUAL
  UNION
		SELECT 15, 'C_DESG', 'ELEMENT', 'CHIDR_DESG' || chr(38) || 'BOMBA' || chr(38) || 'REIXA' || chr(38) || 'TAP_DESG', 'DESGU�S' FROM DUAL
  UNION
		SELECT 16, 'C_ILLU', 'ELEMENT', 'FOCUS', 'IL�LUMINACI�' FROM DUAL
  UNION
		SELECT 17, 'C_IMPU', 'ELEMENT', 'CHIDR_PIMP' || chr(38) || 'FILTRE_BOM' || chr(38) || 'BROLLADOR' || chr(38) || 'BOMBA', 'IMPULSI�' FROM DUAL
  UNION
		SELECT 18, 'C_MANI', 'ELEMENT', 'CELENOIDE' || chr(38) || 'SONDA_NIV', 'MANIOBRA' FROM DUAL
  UNION
		SELECT 19, 'C_RECI', 'ELEMENT', 'CHIDR_RASP' || chr(38) || 'CHIDR_RIMP' || chr(38) || 'REIXA' || chr(38) || 'FILTRE_BOM' || chr(38) || 'FILTRE_SOR' || chr(38) || 'BOMBA' || chr(38) || 'VALV_6VIES', 'RECIRCULACI�' FROM DUAL
  UNION
		SELECT 20, 'C_RETO', 'ELEMENT', 'REIXA', 'RETORN' FROM DUAL;
	


CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.ELEMENT_TYPE AS 

	SELECT  'AIXETA'	    id,
          'true'			  active,
          'true'		    code_autofill,
          'Aixeta'      descript,
          null		      link_path
	FROM DUAL
	UNION
	SELECT	'ARQFONT',     'true', 'true', 'Arqueta Font', null
	FROM DUAL
	UNION
	SELECT	'ARQUETA',     'true', 'true', 'Arqueta', null
	FROM DUAL
	UNION
	SELECT	'PORTELLA',    'true', 'true', 'Portella', null
	FROM DUAL
  UNION
	SELECT	'PLACA',       'true', 'true', 'Placa Hidrant', null
	FROM DUAL
	UNION
	SELECT	'ANALITZADOR', 'true', 'true', 'Analitzador', null
	FROM DUAL
	UNION
	SELECT	'ANEMOMETRE',  'true', 'true', 'Anem�metre', null
	FROM DUAL
	UNION
	SELECT	'ARQBOMB',     'true', 'true', 'Arqueta Bomba', null
	FROM DUAL
	UNION
	SELECT	'BATER_COND',  'true', 'true', 'Bateria de condensadors', null
	FROM DUAL
	UNION
	SELECT	'BOMBA',       'true', 'true', 'Bomba', null
	FROM DUAL
	UNION
	SELECT	'BOMBA_DOSI',  'true', 'true', 'Bomba dosificadora', null
	FROM DUAL
	UNION
	SELECT	'BROLLADOR',   'true', 'true', 'Brolladors', null
	FROM DUAL
	UNION
	SELECT	'CELENOIDE',   'true', 'true', 'Celenoide electrov�lvula', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_DESG',  'true', 'true', 'Circuit hidr�ulic desgu�s', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_EAIG',  'true', 'true', 'Circuit hidr�ulic entrada d''aigua', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_PASP',  'true', 'true', 'Circuit hidr�ulic principal aspiraci�', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_PIMP',  'true', 'true', 'Circuit hidraulic principal impulsi�', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_PRET',  'true', 'true', 'Circuit hidr�ulic principal de retorn', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_RASP',  'true', 'true', 'Circuit hidr�ulic recirculaci� aspiraci�', null
	FROM DUAL
	UNION
	SELECT	'CHIDR_RIMP',  'true', 'true', 'Circuit hidr�ulic recirculaci� impulsi�', null
	FROM DUAL
	UNION
	SELECT	'CIRCUIT_CL',  'true', 'true', 'Circuit cloraci�', null
	FROM DUAL
	UNION
	SELECT	'COMPT_EAIG',  'true', 'true', 'Comptador d''entrada d''aigua', null
	FROM DUAL
	UNION
	SELECT	'COMPT_ELEC',  'true', 'true', 'Comptador el�ctric', null
	FROM DUAL
	UNION
	SELECT	'DATALOG_IN',  'true', 'true', 'Datalogger sonda inundaci�', null
	FROM DUAL
	UNION
	SELECT	'DIFERENCIAL', 'true', 'true', 'Diferencials', null
	FROM DUAL
	UNION
	SELECT	'ELECTROVAL',  'true', 'true', 'Electrov�lvula', null
	FROM DUAL
	UNION
	SELECT	'FILTRE_BOM',  'true', 'true', 'Filtre aspiraci� Bomba', null
	FROM DUAL
	UNION
	SELECT	'FILTRE_SOR',  'true', 'true', 'Filtre de sorra', null
	FROM DUAL
	UNION
	SELECT	'FOCUS',       'true', 'true', 'Focus', null
	FROM DUAL
	UNION
	SELECT	'MAGNETOTER',  'true', 'true', 'Magnetot�rmics', null
	FROM DUAL
	UNION
	SELECT	'QUADRE_EC',   'true', 'true', 'Quadre el�ctric i de comandament', null
	FROM DUAL
	UNION
	SELECT	'REIXA',       'true', 'true', 'Reixa', null
	FROM DUAL
	UNION
	SELECT	'SALA',        'true', 'true', 'Sala', null
	FROM DUAL
	UNION
	SELECT	'SONDA_INUN',  'true', 'true', 'Sonda inundaci�', null
	FROM DUAL
	UNION
	SELECT	'SONDA_NIV',   'true', 'true', 'Sondes de nivell', null
	FROM DUAL
	UNION
	SELECT	'TAP_DESG',    'true', 'true', 'Tap desgu�s', null
	FROM DUAL
	UNION
	SELECT	'VALV_6VIES',  'true', 'true', 'V�lvula sis vies filtre de sorra', null
	FROM DUAL
	UNION
	SELECT	'VALVBOIA',    'true', 'true', 'V�lvula entrada aigua per boia', null
	FROM DUAL
	UNION
	SELECT	'VAS',         'true', 'true', 'Vas', null
	FROM DUAL;

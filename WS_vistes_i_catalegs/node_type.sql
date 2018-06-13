
CREATE OR REPLACE VIEW NODE_TYPE AS 

	SELECT  'HIDRANT'		id,
			'HYDRANT'		type,
			'JUNCTION'		epa_default,
			'man_hydrant'	man_table,
			'inp_junction'	epa_table,
			'true'			active,
			'true'			code_autofill,
			2				num_arcs,
			'false'			choose_hemisphere,
			'Hidrant'		descript,
			null			link_path
	FROM DUAL
	UNION
	SELECT 'CAPTACIO',    'SOURCE',    'JUNCTION', 'man_source',   'inp_junction',  'true', 'true', 2,    'false', 'Captació',              null
	FROM DUAL
	UNION
	SELECT 'BOMBAMENT',   'PUMP',      'PUMP',     'man_pump',     'inp_pump',      'true', 'true', 2,    'false', 'Bombament',             null
	FROM DUAL
	UNION
	SELECT 'COMPTADOR',   'METER',     'JUNCTION', 'man_meter',    'inp_junction',  'true', 'true', 2,    'false', 'Comptador de Control',  null
	FROM DUAL
	UNION
	SELECT 'DIPOSIT',     'TANK',      'TANK',     'man_tank',     'inp_tank',      'true', 'true', NULL, 'false', 'Dipòsit',               null
	FROM DUAL
	UNION
	SELECT 'UNIO',        'JUNCTION',  'JUNCTION', 'man_junction', 'inp_junction',  'true', 'true', 2,    'false', 'Unió',                  null
	FROM DUAL
	UNION
	SELECT 'DERIVACIO',   'JUNCTION',  'JUNCTION', 'man_junction', 'inp_junction',  'true', 'true', 3,    'false', 'Derivació',             null
	FROM DUAL
	UNION
	SELECT 'CREUAMENT',   'JUNCTION',  'JUNCTION', 'man_junction', 'inp_junction',  'true', 'true', 4,    'false', 'Creuament',                  null
	FROM DUAL
	UNION
	SELECT 'INICI_FI',    'JUNCTION',  'JUNCTION', 'man_junction', 'inp_junction',  'true', 'true', 1,    'false', 'Inici / Final',                 null
	FROM DUAL
	UNION
	SELECT 'TAP',	      'JUNCTION',  'JUNCTION', 'man_junction', 'inp_junction',  'true', 'true', 1,    'false', 'Tap',                   null
	FROM DUAL
	UNION
	SELECT 'POU_CONN',    'MANHOLE',   'JUNCTION', 'man_manhole',  'inp_junction',  'true', 'true', 2,    'false', 'Pou de Connexió',       null
	FROM DUAL
	UNION
	SELECT 'POU',         'WATERWELL', 'JUNCTION', 'man_waterwell','inp_junction',  'true', 'true', 1,    'false', 'Pou',                   null
	FROM DUAL
	UNION
	SELECT 'REDUCCIO',    'REDUCTION', 'JUNCTION', 'man_reduction','inp_junction',  'true', 'true', 2,    'false', 'Reducció',              null
	FROM DUAL
	UNION
	SELECT 'VALVULA',	  'VALVE',     'SHORTPIPE','man_valve',    'inp_shortpipe', 'true', 'true', 2,    'false', 'Vàlvula de Comporta',   null
	FROM DUAL
	UNION
	SELECT 'VDESCARREGA', 'VALVE',    'JUNCTION', 'man_valve',    'inp_junction',  'true', 'true', 2,    'false', 'Vàlvula de Descàrrega', null
	FROM DUAL
	UNION
	SELECT 'VENTOSA',	  'VALVE',     'JUNCTION', 'man_valve',    'inp_junction',  'true', 'true', 2,    'false', 'Ventosa',               null
  FROM DUAL
	UNION
	SELECT 'VREGULADORA',	'VALVE',    'VALVE',    'man_valve',    'inp_valve', 'true', 'true', 2,    'false', 'Vàlvula Reguladora',   null
	FROM DUAL;



	/*

distingir tipus 'C' entre Collarí­ i TC


SELECT ID_NODE, COUNT(*)
FROM (
  SELECT T1.ID_NODE, T1.ESTAT, T2.ID_TRAM, T2.ESTAT
  FROM   NA_V_NODE T1
           LEFT JOIN NA_T_TRAM T2 ON T1.ID_NODE = T2.ID_NODE1 AND T2.TIPUS_NODE1 = 'NODE'
  WHERE  T1.NODE_TIPUS = 'C' 
    AND  T2.ESTAT = 'A'
  UNION
  SELECT T1.ID_NODE, T1.ESTAT, T2.ID_TRAM, T2.ESTAT
  FROM   NA_V_NODE T1
           LEFT JOIN NA_T_TRAM T2 ON T1.ID_NODE = T2.ID_NODE2 AND T2.TIPUS_NODE2 = 'NODE'
  WHERE  T1.NODE_TIPUS = 'C' 
    AND  T2.ESTAT = 'A'
) 
GROUP BY ID_NODE    
ORDER BY COUNT(*), ID_NODE;



filtre nodes desconeguts '-'



SELECT ID_NODE, COUNT(*)
FROM (
  SELECT T1.ID_NODE, T1.ESTAT, T2.ID_TRAM, T2.ESTAT
  FROM   NA_V_NODE T1
           LEFT JOIN NA_T_TRAM T2 ON T1.ID_NODE = T2.ID_NODE1 AND T2.TIPUS_NODE1 = 'NODE'
  WHERE  T1.NODE_TIPUS = '-' 
    AND  T2.ESTAT = 'A'
  UNION
  SELECT T1.ID_NODE, T1.ESTAT, T2.ID_TRAM, T2.ESTAT
  FROM   NA_V_NODE T1
           LEFT JOIN NA_T_TRAM T2 ON T1.ID_NODE = T2.ID_NODE2 AND T2.TIPUS_NODE2 = 'NODE'
  WHERE  T1.NODE_TIPUS = '-' 
    AND  T2.ESTAT = 'A'
) 
GROUP BY ID_NODE    
ORDER BY COUNT(*), ID_NODE;

*/
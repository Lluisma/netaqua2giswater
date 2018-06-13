
CREATE OR REPLACE VIEW NODE_TYPE AS 

	SELECT  'CAMBRA'		        id,
			    'CHAMBER'		        type,
			    'STORAGE'	    	    epa_default,
          'man_chamber'	      man_table,
			    'inp_storage' 	    epa_table,
			    'true'			        active,
			    'true'			        code_autofill,
			    null		            num_arcs,
			    'false'			        choose_hemisphere,
			    'Cambra singular'	  descript,
			    null			          link_path
	FROM DUAL
	UNION
	SELECT 'BOMBAMENT',    'CHAMBER', 'STORAGE',   'man_chamber',  'inp_storage', 'true',  'true', 2, 'false', 'Bombament',          null
	FROM DUAL
	UNION
  SELECT 'SOBREEIXIDOR', 'CHAMBER', 'JUNCTION',  'man_chamber',  'inp_junction', 'true', 'true', 2, 'false', 'Sobreeixidor',       null
	FROM DUAL
	UNION
	SELECT 'UNIO',         'JUNCTION', 'JUNCTION', 'man_junction', 'inp_junction', 'true', 'true', 2, 'false', 'Unió de trams',       null
	FROM DUAL
	UNION
  SELECT 'NFICTICI',     'JUNCTION', 'JUNCTION', 'man_junction', 'inp_junction', 'true', 'true', 2, 'false', 'Node fictici',        null
	FROM DUAL
	UNION
  SELECT 'REGISTRE',     'MANHOLE',  'JUNCTION', 'man_manhole',  'inp_junction', 'true', 'true', 2, 'false', 'Pou de registre',     null
	FROM DUAL
  UNION
  SELECT 'SORRER',       'NETINIT',  'JUNCTION', 'man_netinit',  'inp_junction', 'true', 'true', 2, 'false', 'Sorrer',              null
	FROM DUAL
  UNION
  SELECT 'INICI',        'NETINIT',  'JUNCTION', 'man_netinit',  'inp_junction', 'true', 'true', 2, 'false', 'Inici de tram',       null
	FROM DUAL
  UNION
  SELECT 'SUMIDERO',     'NETINIT',  'JUNCTION', 'man_netinit',  'inp_junction', 'true', 'true', 2, 'false', 'Sumidero',            null
	FROM DUAL
  UNION
  SELECT 'DESGUAS',      'OUTFALL',  'OUTFALL',  'man_outfall',  'inp_outfall',  'true', 'true', 2, 'false', 'Punt de desguàs',     null
	FROM DUAL
  UNION
  SELECT 'DESCARREGA',   'OUTFALL',  'OUTFALL',  'man_outfall',  'inp_outfall',  'true', 'true', 2, 'false', 'Descàrrega',          null
	FROM DUAL
  UNION
  SELECT 'VALVULA',      'VALVE',    'JUNCTION', 'man_valve',    'inp_junction', 'true', 'true', 2, 'false', 'Vàlvula',             null
	FROM DUAL
  UNION
  SELECT 'VENTOSA',      'VALVE',    'JUNCTION', 'man_valve',    'inp_junction', 'true', 'true', 2, 'false', 'Ventosa',             null
	FROM DUAL
  UNION
  SELECT 'VRETENCIO',    'VALVE',    'JUNCTION', 'man_valve',    'inp_junction', 'true', 'true', 2, 'false', 'Vàlvula de retenció', null
	FROM DUAL;
  
  
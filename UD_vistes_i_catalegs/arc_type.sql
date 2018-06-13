
CREATE OR REPLACE VIEW ARC_TYPE AS 

	SELECT  'TRAM'		              id,
			    'CONDUIT'		            type,
			    'CONDUIT'		            epa_default,
    			'man_conduit'	          man_table,
			    'inp_conduit'	          epa_table,
			    'true'		              active,
			    'true'	       	        code_autofill,
			    'Tram de clavegueram'   descript,
			    null		                link_path
	FROM DUAL
  UNION
  SELECT  'RIERA', 'CONDUIT', 'CONDUIT', 'man_conduit', 'inp_conduit', 'true', 'true', 'Tram de riera', null
  FROM DUAL
  UNION
  SELECT  'CUNETA', 'CONDUIT', 'CONDUIT', 'man_conduit', 'inp_conduit', 'true', 'true', 'Cuneta',       null
  FROM DUAL;

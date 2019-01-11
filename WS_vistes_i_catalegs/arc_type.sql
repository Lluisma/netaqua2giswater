
CREATE OR REPLACE VIEW ARC_TYPE AS 

	SELECT  'PIPE'		id,
			'PIPE'		    type,
			'PIPE'		    epa_default,
			'man_pipe'	  man_table,
			'inp_pipe'	  epa_table,
			'true'		    active,
			'true'		    code_autofill,
			'Canonada'		descript,
			null          link_path
	FROM DUAL
	UNION
	SELECT	'VARC','VARC','PIPE','man_varc','inp_pipe','true','true','Arc virtual',null
	FROM DUAL;

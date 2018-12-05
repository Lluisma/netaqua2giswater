

CREATE OR REPLACE VIEW MAN_ADDFIELDS_PARAMETER AS

	SELECT	1							              id,
          'font_continuous'		      	param_name,
          'FONT'						          cat_feature_id,
          'false'						          is_mandatory,
          'text'					            datatype_id,
          10							            field_length,
          null 						            num_decimals,
          null 						            default_value,
          'Raig continu'				      form_label,
          'QComboBox'						      widgettype_id,	
          'amsa_cat_font_continuous'  dv_table,
          'id_font_continuous'		    dv_key_column,
          'value_font_continuous'		  dv_value_column	,
            null					            sql_text	
	FROM DUAL

	UNION

	SELECT	2, 'cat_valve_wjoin',  'FONT',     'false', 'text',    2, null, null,  'Vàlvula arq. esco associada',   'QComboBox', 'amsa_cat_font_arq_valv', 'id_font_arq_valv', 'value_font_arq_valv', null
	FROM DUAL

	UNION

	SELECT	3, 'chest_distance',   'FONT',     'false', 'numeric', 10, 2,   null,  'Distància arqueta (m)',	        'QLineEdit', null, null, null, null
	FROM DUAL

	UNION

	SELECT	4, 'pcar_racor_diam',  'PUNT_CAR', 'false', 'integer', 5, 0,    null,  'Diàmetre Racor (mm)',           'QComboBox', 'amsa_cat_pcar_racor_diam', 'id_pcar_racor_diam', 'id_pcar_racor_diam', null
	FROM DUAL

	UNION

	SELECT	5, 'pipe_inv',         'PIPE',     'false', 'text',    10, null, null, 'Grup Inversió',                 'QComboBox', 'amsa_cat_pipe_inv_tipus',  'id_inv_tipus',       'value_inv_tipus',    null
	FROM DUAL

	UNION

	SELECT	6, 'pipe_asbextract',  'PIPE',     'false', 'boolean',  1, null, null, 'Retirada de Fibrociment',       'QCheckBox', null, null, null, null
	FROM DUAL

	UNION

	SELECT	7, 'dipo_initlevel',   'DIPOSIT',  'false', 'numeric',  5, 2,    null, 'Nivell Inicial (m)',            'QLineEdit', null, null, null, null
	FROM DUAL
	UNION  
	SELECT	8, 'dipo_minlevel',    'DIPOSIT',  'false', 'numeric',  5, 2,    null, 'Nivell Mínim (m)',              'QLineEdit', null, null, null, null
	FROM DUAL
	UNION
	SELECT	9, 'dipo_maxlevel',    'DIPOSIT',  'false', 'numeric',  5, 2,    null, 'Nivell Màxim (m)',              'QLineEdit', null, null, null, null
	FROM DUAL
	UNION
	SELECT	10, 'dipo_diameter',   'DIPOSIT',  'false', 'numeric',  5, 2,    null, 'Diàmetre (m)',                  'QLineEdit', null, null, null, null
	FROM DUAL

	UNION

	SELECT	11, 'vreg_dynamics',   'VALVULA',  'false', 'numeric', 10, 5,    null, 'Reguladora: Dinàmica (Kg/cm²)', 'QLineEdit', null, null, null, null
	FROM DUAL
	UNION  
	SELECT  12, 'vreg_filter',     'VALVULA',  'false', 'boolean',  2, null, null, 'Reguladora: Filtre',            'QCheckBox', null, null, null, null
	FROM DUAL

	ORDER BY 1;	


--   select * FROM   NA_MATARO.na_t_caracteristica;
		


CREATE OR REPLACE VIEW AMSA_CAT_FONT_CONTINUOUS AS
	SELECT ID_FONT_RAIG_CONTINU 		id_font_continuous, 
		   FONT_RAIG_CONTINU 			value_font_continuous 
	FROM   NA_MATARO.CAT2_T_FONT_RAIG_CONTINU;


CREATE OR REPLACE VIEW AMSA_CAT_FONT_ARQ_VALV AS
	SELECT ID_FONT_ARQUETA_VALV 		id_font_arq_valv, 
		   FONT_ARQUETA_VALV 			value_font_arq_valv
	FROM   NA_MATARO.CAT2_T_FONT_ARQUETA_VALV;


CREATE OR REPLACE VIEW AMSA_CAT_PCAR_RACOR_DIAM AS

    SELECT ID_PCAR_DIAM_RAC      		id_pcar_racor_diam
    FROM   NA_MATARO.CAT2_T_PCAR_DIAMETRE_RACOR;
  

CREATE OR REPLACE VIEW AMSA_CAT_PIPE_INV_TIPUS AS

    SELECT ID_TIPUS_INVERSIO 			id_inv_tipus, 
    	   TIPUS_INVERSIO 				value_inv_tipus 
   	FROM   NA_MATARO.CAT2_T_TIPUS_INVERSIO
   	ORDER BY ID_INV_TIPUS;



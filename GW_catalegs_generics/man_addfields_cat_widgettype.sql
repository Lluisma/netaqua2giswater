
CREATE OR REPLACE VIEW MAN_ADDFIELDS_CAT_WIDGETTYPE AS

  SELECT 'QLineEdit'  id, 'Casella de text'     descript FROM DUAL
  UNION
  SELECT 'QComboBox'  id, 'Desplegable'         descript FROM DUAL
  UNION
  SELECT 'QCheckBox'  id, 'Checkbox true/false' descript FROM DUAL
  UNION
  SELECT 'QDateEdit'  id, 'Data'                descript FROM DUAL;
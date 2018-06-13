
CREATE OR REPLACE VIEW MAN_ADDFIELDS_CAT_DATATYPE AS

  SELECT 'integer'  id, null descript FROM DUAL
  UNION
  SELECT 'text'     id, null descript FROM DUAL
  UNION
  SELECT 'date'     id, null descript FROM DUAL
  UNION
  SELECT 'boolean'  id, null descript FROM DUAL
  UNION
  SELECT 'numeric'  id, null descript FROM DUAL;
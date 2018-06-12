
-- ABASTAMENT

CLEAR 

DECLARE
  
  sent_sql VARCHAR2 (30000) := '';
  
BEGIN

  FOR R IN (SELECT ID_TIPUS FROM NA_MATARO.NA_T_TIPUS_ELEMENT WHERE ID_TIPUS <> 'CAPT') LOOP
  
    IF sent_sql IS NOT NULL THEN
        sent_sql :=  sent_sql || ' UNION ';
    END IF;
  
    sent_sql := sent_sql ||
               ' SELECT DISTINCT CASE WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT ' ||
               '                      WHEN T1.OT_PART = ''0'' THEN T1.EXPEDIENT ' ||
               '                      ELSE T1.EXPEDIENT || ''-'' || T1.OT_PART ' ||
               '       END AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPEDIENT AS workid_key1, ' ||
               '       CASE WHEN T1.OT_PART = ''0'' THEN NULL ' ||
               '            ELSE T1.OT_PART ' ||
               '       END AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_MATARO.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPEDIENT <> ''0'') ' ||
               'UNION ' ||
               'SELECT DISTINCT CASE WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA ' ||
               '                     WHEN T1.OT_BAIXA_PART = ''0'' THEN T1.EXPBAIXA ' ||
               '                     ELSE T1.EXPBAIXA || ''-'' || T1.OT_BAIXA_PART ' ||
               '       END AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPBAIXA AS workid_key1, ' ||
               '       CASE WHEN T1.OT_BAIXA_PART = ''0'' THEN NULL ' ||
               '            ELSE T1.OT_BAIXA_PART ' ||
               '       END AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_MATARO.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPBAIXA <> ''0'') ';
               
  END LOOP;
  
  EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW TMP_CAT_WORK_MATARO AS ' || sent_sql;
  --dbms_output.put_line('CREATE OR REPLACE VIEW TMP_CAT_WORK_MATARO AS ' || sent_sql);

  sent_sql := '';

  FOR R IN (SELECT ID_TIPUS FROM NA_FIGARO.NA_T_TIPUS_ELEMENT WHERE ID_TIPUS <> 'BATE') LOOP
  
    IF sent_sql IS NOT NULL THEN
        sent_sql := sent_sql || ' UNION ';
    END IF;
  
    sent_sql :=  sent_sql ||
               ' SELECT DISTINCT CASE WHEN T1.ACTUACIO IS NULL THEN T1.EXPEDIENT ' ||
               '                      WHEN T1.ACTUACIO = ''0'' THEN T1.EXPEDIENT ' ||
               '                      ELSE T1.EXPEDIENT || ''-'' || T1.ACTUACIO ' ||
               '       END AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPEDIENT AS workid_key1, ' ||
               '       CASE WHEN T1.ACTUACIO = ''0'' THEN NULL ' ||
               '            ELSE TO_NUMBER(T1.ACTUACIO) ' ||
               '       END AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_FIGARO.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPEDIENT <> ''0'') ' ||
               'UNION ' ||
               'SELECT DISTINCT T1.EXPBAIXA AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPBAIXA AS workid_key1, ' ||
               '       NULL AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_FIGARO.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPBAIXA <> ''0'') ';
               
  END LOOP;
  
  EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW TMP_CAT_WORK_FIGARO AS ' || sent_sql;
  --dbms_output.put_line('CREATE OR REPLACE VIEW TMP_CAT_WORK_FIGARO AS ' || sent_sql);

  sent_sql := '';

  FOR R IN (SELECT ID_TIPUS FROM NA_LLISSADEVALL.NA_T_TIPUS_ELEMENT WHERE ID_TIPUS <> 'BATE') LOOP
  
    IF sent_sql IS NOT NULL THEN
        sent_sql := sent_sql || ' UNION ';
    END IF;
  
    sent_sql :=  sent_sql ||
               ' SELECT DISTINCT CASE WHEN T1.ACTUACIO IS NULL THEN T1.EXPEDIENT ' ||
               '                      WHEN T1.ACTUACIO = ''0'' THEN T1.EXPEDIENT ' ||
               '                      ELSE T1.EXPEDIENT || ''-'' || T1.ACTUACIO ' ||
               '       END AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPEDIENT AS workid_key1, ' ||
               '       CASE WHEN T1.ACTUACIO = ''0'' THEN NULL ' ||
               '            ELSE TO_NUMBER(T1.ACTUACIO) ' ||
               '       END AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_LLISSADEVALL.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPEDIENT <> ''0'') ' ||
               'UNION ' ||
               'SELECT DISTINCT T1.EXPBAIXA AS id, ' ||
               '       NULL AS descript, ' ||
               '       NULL AS link, ' ||
               '       T1.EXPBAIXA AS workid_key1, ' ||
               '       NULL AS workid_key2, ' ||
               '       NULL AS builtdate ' ||
               'FROM  NA_LLISSADEVALL.NA_V_' || R.ID_TIPUS || ' T1 ' ||
               'WHERE (T1.EXPBAIXA <> ''0'') ';
               
  END LOOP;
  
  EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW TMP_CAT_WORK_LLISSADEVALL AS ' || sent_sql;
  --dbms_output.put_line('CREATE OR REPLACE VIEW TMP_CAT_WORK_LLISSADEVALL AS ' || sent_sql);
         
END;


CREATE OR REPLACE VIEW CAT_WORK AS

  SELECT ID, DESCRIPT, LINK, WORKID_KEY1, WORKID_KEY2, BUILTDATE FROM TMP_CAT_WORK_MATARO
  UNION ALL
  SELECT  ID, DESCRIPT, LINK, WORKID_KEY1, WORKID_KEY2, BUILTDATE FROM TMP_CAT_WORK_FIGARO
  UNION ALL
  SELECT ID, DESCRIPT, LINK, WORKID_KEY1, WORKID_KEY2, BUILTDATE FROM TMP_CAT_WORK_LLISSADEVALL
  ORDER BY WORKID_KEY1, WORKID_KEY2;



/*
  REVISIONS
  =================================================================================================

  CREATE OR REPLACE VIEW REVI_CAT_WORK AS
  SELECT *
  FROM   CAT_WORK
  WHERE  workid_key1 LIKE '%-%'
     OR  (SUBSTR(workid_key1, 0, 1)<>'M' AND SUBSTR(workid_key1, 0, 1)<>'N' AND SUBSTR(workid_key1, 0, 1)<>'P'
          AND SUBSTR(workid_key1, 0, 2)<>'AE' AND SUBSTR(workid_key1, 0, 2)<>'XE')
  UNION
  SELECT *
  FROM   CAT_WORK
  WHERE  (SUBSTR(workid_key1, 0, 2)='AE' OR SUBSTR(workid_key1, 0, 2)='XE')
    AND  workid_key2 IS NOT NULL
  UNION
  SELECT *
  FROM   CAT_WORK
  WHERE  workid_key1 IS NULL
    AND  workid_key2 IS NOT NULL;

*/

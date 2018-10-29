
CREATE OR REPLACE FUNCTION ws_migra.urn_create_tables() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_insert        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
  nom               TEXT;
BEGIN

  EXECUTE 'DROP TABLE IF EXISTS ' || schema1 || '.amsa_urn';

  EXECUTE 'CREATE TABLE ' || schema1 || '.amsa_urn ( '
       || '  id_nou        SERIAL, '
       || '  nodetype_id   CHARACTER VARYING(30), '
       || '  id_element    CHARACTER VARYING(16), '
       || '  id_amsa       CHARACTER VARYING(30), '
       || '  expl_id       INTEGER '  
       || '  )';


  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn (nodetype_id, id_element, id_amsa, expl_id) '
      ||  'SELECT ''pipe'', arc_id, code, expl_id FROM ' || schema1 || '.v_edit_man_pipe '
      ||  'ORDER BY expl_id, CAST(arc_id AS INTEGER)';
  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn (nodetype_id, id_element, id_amsa, expl_id) '
       || 'SELECT ''varc'', arc_id, code, expl_id FROM ' || schema1 || '.v_edit_man_varc '
       || 'ORDER BY expl_id, CAST(arc_id AS INTEGER)';

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    AND  table_name LIKE 'v_edit_man_%'
    AND  table_name NOT LIKE 'v_edit_%_pol'
    AND  table_name NOT IN ('v_edit_man_pipe','v_edit_man_varc', 'v_edit_man_fountain','v_edit_man_greentap','v_edit_man_tap','v_edit_man_wjoin')
  LOOP
    nom := replace(rec.table_name, 'v_edit_man_', '');
    sql_insert := 'INSERT INTO ' || schema1 || '.amsa_urn(nodetype_id, id_element, id_amsa, expl_id) ' 
               || 'SELECT nodetype_id, node_id, code, expl_id FROM ' || schema1 || '.' || rec.table_name || ' '
               || 'ORDER BY expl_id, CAST(node_id AS INTEGER)';
    EXECUTE sql_insert;
  END LOOP;

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    and  table_name in ('v_edit_man_fountain','v_edit_man_greentap','v_edit_man_tap','v_edit_man_wjoin')
  LOOP
    nom := replace(rec.table_name, 'v_edit_man_', '');
    sql_insert := 'INSERT INTO ' || schema1 || '.amsa_urn(nodetype_id, id_element, id_amsa, expl_id) ' 
               || 'SELECT connectype_id, connec_id, code, expl_id FROM ' || schema1 || '.' || rec.table_name || ' '
               || 'ORDER BY expl_id, CAST(connec_id AS INTEGER)';  
--RAISE NOTICE USING MESSAGE = nom;
    EXECUTE sql_insert;
  END LOOP;



  EXECUTE 'DROP TABLE IF EXISTS ' || schema1 || '.amsa_urn_element';

  EXECUTE 'CREATE TABLE ' || schema1 || '.amsa_urn_element ( '
       || '  id_nou        SERIAL, '
       || '  id_vell       CHARACTER VARYING(30) '
       || '  )';

  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn_element (id_vell) '
      ||  'SELECT element_id FROM ' || schema1 || '.v_edit_element ';
  


  RETURN 'Taules amsa_urn/amsa_urn_element actualitzada';
END
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION ws_migra.urn_set() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_update        TEXT;
  sql_count         TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
  nom               TEXT;
BEGIN

  EXECUTE 'UPDATE ' || schema1 || '.v_edit_man_pipe '
       || '   SET arc_id = id_nou '
       || 'FROM   ' || schema1 || '.amsa_urn '
       || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ''pipe'' '
       || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_pipe.arc_id '
       || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_pipe.code '
       || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.v_edit_man_pipe.expl_id';

  EXECUTE 'UPDATE ' || schema1 || '.v_edit_man_varc '
       || '   SET arc_id = id_nou '
       || 'FROM   ' || schema1 || '.amsa_urn '
       || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ''varc'' '
       || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_varc.arc_id '
       || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_varc.code '
       || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.v_edit_man_varc.expl_id';


  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    and  table_name like 'v_edit_man_%'
    and  table_name not in ('v_edit_man_pipe','v_edit_man_varc',
                            'v_edit_man_fountain','v_edit_man_greentap','v_edit_man_tap','v_edit_man_wjoin',
                            'v_edit_man_fountain_pol', 'v_edit_man_register_pol', 'v_edit_man_tank_pol',
                            'v_edit_man_expansiontank','v_edit_man_netsamplepoint')
  LOOP
    nom := replace(rec.table_name, 'v_edit_man_', '');
    sql_update := 'UPDATE ' || schema1 || '.' || rec.table_name || ' '
               || '   SET node_id = id_nou '
               || 'FROM   ' || schema1 || '.amsa_urn '
               || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.' || rec.table_name || '.nodetype_id '
               || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.' || rec.table_name || '.node_id '
               || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.' || rec.table_name || '.code '
               || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.' || rec.table_name || '.expl_id';
    EXECUTE sql_update;
  END LOOP;

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    and  table_name in ('v_edit_man_fountain','v_edit_man_greentap','v_edit_man_tap','v_edit_man_wjoin')
  LOOP
    nom := replace(rec.table_name, 'v_edit_man_', '');
    sql_update := 'UPDATE ' || schema1 || '.' || rec.table_name || ' '
               || '   SET connec_id = id_nou '
               || 'FROM   ' || schema1 || '.amsa_urn '
               || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.' || rec.table_name || '.connectype_id '
               || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.' || rec.table_name || '.connec_id '
               || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.' || rec.table_name || '.code '
               || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.' || rec.table_name || '.expl_id';
--RAISE NOTICE USING MESSAGE = nom;
    EXECUTE sql_update;
  END LOOP;

  
  RETURN 'Taules actualitzades amb el nou id';
END
$$ LANGUAGE plpgsql;


/*

Aquesta sentència d'actualització és molt més lenta

UPDATE ws_migra.v_edit_man_pipe SET (arc_id) =
    (SELECT id_nou
     FROM   ws_migra.amsa_urn
     WHERE  ws_migra.amsa_urn.tip_element = 'pipe'
       AND  ws_migra.amsa_urn.id_element  = v_edit_man_pipe.arc_id
       AND  ws_migra.amsa_urn.id_amsa     = v_edit_man_pipe.pipe_code
       AND  ws_migra.amsa_urn.expl_id     = v_edit_man_pipe.expl_id);


*/



CREATE OR REPLACE FUNCTION ws_migra.urn_set_linked() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  recompte          INTEGER;
  compt             INTEGER := 0;
  sql_update        TEXT;
  sql_count         TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  -- TAP    LINKED_CONNEC NA_V_FONT.ESCOMESA    (CODI_COM)

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_tap '
             || '     SET linked_connec = null  '
             || '  WHERE  linked_connec = ''0'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_tap >> Valors 0 a null : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_tap '
             || '     SET linked_connec = ' || schema1 || '.v_edit_man_wjoin.connec_id '
             || '  FROM   ' || schema1 || '.v_edit_man_wjoin '
             || '  WHERE  ' || schema1 || '.v_edit_man_tap.linked_connec = ' || schema1 || '.v_edit_man_wjoin.code '
             || '    AND  ' || schema1 || '.v_edit_man_tap.expl_id = ' || schema1 || '.v_edit_man_wjoin.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_tap.linked_connec IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_tap >> Valors actualitzats : ' || recompte;

  compt := compt + 1;  


  -- FOUNTAIN  LINKED_CONNEC NA_V_FOOR.ESCOMESA_NUM  (CODI_COM)

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_fountain '
             || '     SET linked_connec = null  '
             || '  WHERE  linked_connec = ''0'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_fountain >> Valors 0 a null : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_fountain '
             || '     SET linked_connec = ' || schema1   || '.v_edit_man_wjoin.connec_id '
             || '  FROM   ' || schema1 || '.v_edit_man_wjoin '
             || '  WHERE  ' || schema1 || '.v_edit_man_fountain.linked_connec = ' || schema1 || '.v_edit_man_wjoin.code '
             || '    AND  ' || schema1 || '.v_edit_man_fountain.expl_id = ' || schema1 || '.v_edit_man_wjoin.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_fountain.linked_connec IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_fountain >> Valors actualitzats : ' || recompte;

  compt := compt + 1;  


  -- WJOIN   ARC_ID      NA_V_ESCO.ID_TRAM

/*
  sql_count := 'WITH rows AS ( '
            || '  SELECT * '
            || '  FROM   ws_migra.v_edit_man_wjoin T1, ws_migra.v_edit_man_varc T2 '
            || '  WHERE  T1.arc_id = T2.arc_id '
            || '  RETURNING 1) '
            || 'SELECT count(*) FROM rows';

  EXECUTE sql_count INTO recompte;

  IF (recompte > 0) THEN 
    RAISE EXCEPTION USING MESSAGE = ' ERROR *** HI HA ' || recompte || ' ESCOMESES CONNECTADES A TRAMS VIRTUALS!! ';
  END IF;
*/

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_wjoin '
             || '     SET arc_id = ' || schema1 ||  '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_man_wjoin.arc_id = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_man_wjoin.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''pipe'' '
             || '    AND  ' || schema1 || '.v_edit_man_wjoin.arc_id IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_wjoin (PIPE) >> Valors actualitzats : ' || recompte;


  compt := compt + 1;  


  -- SAMPLEPOINT  FEATURE_ID    NA_V_MOST.ELEMCODI  

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_samplepoint '
             || '     SET feature_id = ' || schema1   || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_samplepoint.feature_id = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_samplepoint.featurecat_id = ' || schema1 || '.amsa_urn.nodetype_id '
             || '    AND  ' || schema1 || '.v_edit_samplepoint.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_samplepoint >> Valors actualitzats : ' || recompte;

  compt := compt + 1;  



  -- POOL    CONNEC_ID   NA3_T_PISC.ID_ESCO

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_pool '
             || '     SET connec_id = null  '
             || '  WHERE  connec_id = ''0'' OR connec_id = ''-1'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_fountain >> Valors 0 a null : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_pool '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_pool.connec_id = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_pool.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''ESCOMESA'' '
             || '    AND  ' || schema1 || '.v_edit_pool.connec_id IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_pool >> Valors actualitzats : ' || recompte;

  compt := compt + 1;  



  RETURN 'Taules amb connec_id actualitzats \n  amb el nou id';
  
END
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION ws_migra.urn_set_arcnodes() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  recompte          INTEGER;
  compt             INTEGER := 0;
  sql_update        TEXT;
  sql_count         TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

/*
-- ** PROVISIONAL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_pipe SET node_1 = NULL WHERE node_1 LIKE ''zERR%'' ';
  EXECUTE sql_update;
  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_pipe SET node_2 = NULL WHERE node_2 LIKE ''zERR%'' ';
  EXECUTE sql_update;
  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_varc SET node_1 = NULL WHERE node_1 LIKE ''zERR%'' ';
  EXECUTE sql_update;
  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_varc SET node_2 = NULL WHERE node_2 LIKE ''zERR%'' ';
  EXECUTE sql_update;

-- ** PROVISIONAL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_pipe '
             || '     SET node_1 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_man_pipe.node_1 = ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_man_pipe.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_pipe.node_1 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_pipe [ NODE_1 ] >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_pipe '
             || '     SET node_2 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_man_pipe.node_2 = ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_man_pipe.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_pipe.node_2 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_pipe [ NODE_2 ] >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_varc '
             || '     SET node_1 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_man_varc.node_1 = ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_man_varc.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_varc.node_1 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_varc [ NODE_1 ] >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_varc '
             || '     SET node_2 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.v_edit_man_varc.node_2 = ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '    AND  ' || schema1 || '.v_edit_man_varc.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.v_edit_man_varc.node_2 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_varc [ NODE_2 ] >> Valors actualitzats : ' || recompte;

  RETURN 'Nodes inicials i finals de pipe i arc actualitzats amb el nou id';
  
END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ws_migra.urn_set_addfields() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_insert        TEXT;
  sql_truncate      TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  sql_truncate := 'TRUNCATE TABLE ' || schema1 || '.man_addfields_value';
  EXECUTE sql_truncate;

  sql_insert := 'WITH rows AS ( '
             || '  INSERT INTO ' || schema1 || '.man_addfields_value '
             || '  SELECT T1.id, T2.id_nou, T1.parameter_id, T1.value_param '
             || '  FROM   ' || schema1 || '.man_addfields_value_tmp T1 '
             || '           LEFT JOIN  ' || schema1 || '.amsa_urn T2 '
             || '             ON CAST(T1.feature_id AS VARCHAR) = T2.id_element '
             || '            AND CAST(T1.id_amsa AS VARCHAR) = T2.id_element '
             || '            AND UPPER(T1.featurecat_id) = UPPER(T2.nodetype_id) '
             || '            AND T1.expl_id = T2.expl_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_insert INTO recompte;
  RAISE NOTICE USING MESSAGE = 'man_addfields_value >> Valors actualitzats : ' || recompte;

  RETURN 'Camps addicionals actualitzats amb el nou id';
  
END
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION ws_migra.urn_set_rev_tables() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_greentap '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_greentap.connec_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_greentap.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_greentap.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''BOCA_REG'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_greentap >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_tap '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_tap.connec_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_tap.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_tap.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''FONT'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_tap >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_wjoin '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_wjoin.connec_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_wjoin.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_wjoin.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''ESCOMESA'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_wjoin >> Valors actualitzats : ' || recompte;



  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_hydrant '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_hydrant.connec_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_hydrant.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_hydrant.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''HIDRANT'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_hydrant >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_valve '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_valve.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_valve.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_valve.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_rev_t_valve.nodetype_id = ' || schema1 || '.amsa_urn.nodetype_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_valve >> Valors actualitzats : ' || recompte;


/*
  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_samplepoint '
             || '     SET connec_id = ' || schema1 || '.v_edit_samplepoint.sample_id '
             || '  FROM   ' || schema1 || '.v_edit_samplepoint '
             || '  WHERE  ' || schema1 || '.amsa_rev_t_samplepoint.code = ' || schema1 || '.v_edit_samplepoint.code '
             || '    AND  ' || schema1 || '.amsa_rev_t_samplepoint.expl_id = ' || schema1 || '.v_edit_samplepoint.expl_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_samplepoint >> Valors actualitzats : ' || recompte;
*/


  RETURN 'Taules de revisió actualitzades amb el nou id';
  
END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ws_migra.urn_set_elements() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  sql_update := 'WITH rows AS ( ' 
             || '  UPDATE ' || schema1 || '.v_edit_element '
             || '   SET element_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn_element '
             || '  WHERE  ' || schema1 || '.amsa_urn_element.id_vell  = ' || schema1 || '.v_edit_element.element_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_element >> IDs ELEMENTS ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.element_x_connec '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.element_x_connec.connec_id = ' || schema1 || '.amsa_urn.expl_id  || ''_'' || ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'element_x_connec >> IDs CONNECS actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( ' 
             || '  UPDATE ' || schema1 || '.element_x_connec '
             || '   SET element_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn_element '
             || '  WHERE  ' || schema1 || '.amsa_urn_element.id_vell  = ' || schema1 || '.element_x_connec.element_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'element_x_connec >> IDs ELEMENTS actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.element_x_node '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.element_x_node.node_id = ' || schema1 || '.amsa_urn.expl_id || ''_'' || ' || schema1 || '.amsa_urn.nodetype_id || ''_'' || ' || schema1 || '.amsa_urn.id_element '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'element_x_node >> IDs NODES actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( ' 
             || '  UPDATE ' || schema1 || '.element_x_node '
             || '     SET element_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn_element '
             || '  WHERE  ' || schema1 || '.amsa_urn_element.id_vell  = ' || schema1 || '.element_x_node.element_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'element_x_node >> IDs ELEMENTS actualitzats : ' || recompte;



  --EXECUTE 'UPDATE ' || schema1 || '.element_x_arc '
  --     || '   SET element_id = id_nou '
  --     || 'FROM   ' || schema1 || '.amsa_urn_element '
  --     || 'WHERE  ' || schema1 || '.amsa_urn_element.id_vell  = ' || schema1 || '.element_x_arc.element_id ';


  RETURN 'Taules de relació element - node/connec actualitzades amb el nou id';
  
END
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION ws_migra.urn_set_mincut() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.anl_mincut_result_connec '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element = ' || schema1 || '.anl_mincut_result_connec.connec_id ' 
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''ESCOMESA'' '
             || '    AND  ' || schema1 || '.amsa_urn.expl_id  = 1 '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'anl_mincut_result_connec >> IDs CONNECS actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.anl_mincut_result_cat '
             || '     SET anl_feature_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.anl_mincut_result_cat.anl_feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.anl_mincut_result_cat.anl_feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''pipe'' '
             || '    AND  ' || schema1 || '.amsa_urn.expl_id     = 1 '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'anl_mincut_result_cat >> anl_feature_id actualitzats : ' || recompte;


  RETURN 'Taules de mincut actualitzades amb el nou id';

END
$$ LANGUAGE plpgsql;


/*

CREATE TABLE ws_migra.amsa_connec_to_link
(
  connec_id     character varying(16),
  connec_geom   geometry(Point,25831),
  link_id       integer,
  first_vtx     geometry,
  end_vtx       geometry,
  closest_pnt   geometry,
  sel_vtx       character varying(3)
)

*/




CREATE OR REPLACE FUNCTION ws_migra.connec_to_link() 
RETURNS TEXT AS $$
DECLARE
  sql_truncate      TEXT;
  sql_create        TEXT;
  sql_update        TEXT;
  recompte          INTEGER;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  sql_truncate := 'TRUNCATE ' || schema1 || '.amsa_connec_to_link';
  EXECUTE sql_truncate;

  sql_create := 'INSERT INTO ' || schema1 || '.amsa_connec_to_link '
             || '  SELECT connec_id, v_edit_man_wjoin.the_geom connec_geom, '
             || '         link_id, ST_StartPoint(v_edit_link.the_geom) first_vtx, ST_EndPoint(v_edit_link.the_geom) end_vtx, '
             || '         ST_ClosestPoint(v_edit_link.the_geom, v_edit_man_wjoin.the_geom) as closest_pnt, CAST(null AS VARCHAR(3)) sel_vtx '
             || '  FROM ' || schema1 || '.v_edit_man_wjoin,' || schema1 || '.v_edit_link '
             || '  WHERE ST_DWithin(v_edit_link.the_geom, v_edit_man_wjoin.the_geom, 0.2)';
  EXECUTE sql_create;

  -- Identifica els casos en que closest_pnt és més a prop del vèrtex final que de l'inicial i després els canvia de sentit

--  EXECUTE 'ALTER TABLE ws_migra.amsa_connec_to_link ALTER COLUMN sel_vtx SET DATA TYPE VARCHAR(3)';

  sql_update := 'UPDATE ' || schema1 || '.amsa_connec_to_link '
             || '   SET sel_vtx = CASE '
             || '                   WHEN ST_Distance(first_vtx, closest_pnt) > ST_Distance(end_vtx, closest_pnt) THEN ''END'' '
             || '                   ELSE ''INI'' '
             || '                 END ';
  EXECUTE sql_update;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_link '
             || '     SET the_geom = ST_Reverse(the_geom) '
             || '  WHERE  link_id IN ( '
             || '    SELECT link_id '
             || '    FROM   ' || schema1 || '.amsa_connec_to_link '
             || '    WHERE  sel_vtx = ''END'' '
             || '  ) '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_link >> Corregides les direccions de les connexions : ' || recompte;

  -- Ajusta els nodes a l'extrem inicial del link

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_wjoin '
             || '     SET the_geom = CASE '
             || '                   WHEN sel_vtx = ''END'' THEN ' || schema1 || '.amsa_connec_to_link.end_vtx '
             || '                   ELSE ' || schema1 || '.amsa_connec_to_link.first_vtx '
             || '                END '
             || '  FROM   ' || schema1 || '.amsa_connec_to_link '
             || '  WHERE  ' || schema1 || '.v_edit_man_wjoin.connec_id = ' || schema1 || '.amsa_connec_to_link.connec_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_wjoin >> Posicions corregides sobre v_edit_link : ' || recompte;              


  RETURN 'Corregides les posicions dels connecs sobre els links';
  
END
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION ws_migra.set_values() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  -- S'assigna el valor de expl_id a dma_id

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name like 'v_edit_%'
      AND  table_name NOT IN ('v_edit_dimensions','v_edit_element')
      AND  table_name NOT LIKE ('%_pol%')
  LOOP
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET dma_id = expl_id*100';
  END LOOP;


  -- S'assigna nul a sector_id

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name like 'v_edit_%'
      AND  table_name NOT IN ('v_edit_dimensions','v_edit_element','v_edit_samplepoint','v_edit_pond','v_edit_pool',
                              'v_edit_man_pipe', 'v_edit_man_varc')
      AND  table_name NOT LIKE ('%_pol%')
  LOOP
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET sector_id = null';
  END LOOP;

  -- S'assigna nul a macrosector_id

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name like 'v_edit_%'
      AND  table_name NOT IN ('v_edit_dimensions','v_edit_element','v_edit_samplepoint','v_edit_pond','v_edit_pool', 
                              'v_edit_man_pipe', 'v_edit_man_varc', 'v_edit_vnode')
      AND  table_name NOT LIKE ('%_pol%')
  LOOP
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET macrosector_id = null';
  END LOOP;

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name like 'v_edit_%'
      AND  table_name NOT IN ('v_edit_dimensions','v_edit_element', 'v_edit_link', 'v_edit_vnode',
                              'v_edit_pool', 'v_edit_pond', 'v_edit_samplepoint')
      AND  table_name NOT LIKE ('%_pol%')
  LOOP
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET state_type = 0 WHERE state_type IS NULL AND state = 0';
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET state_type = 11 WHERE state_type IS NULL AND state = 1';
  END LOOP;

  RETURN 'Corregits els valors per defecte de dma_id i state_type';

END
$$ LANGUAGE plpgsql;
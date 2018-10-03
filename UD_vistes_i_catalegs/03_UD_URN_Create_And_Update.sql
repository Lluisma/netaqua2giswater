
CREATE OR REPLACE FUNCTION ud_migra.urn_create_tables() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_insert        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  EXECUTE 'DROP TABLE IF EXISTS ' || schema1 || '.amsa_urn';

  EXECUTE 'CREATE TABLE ' || schema1 || '.amsa_urn ( '
       || '  id_nou        SERIAL, '
       || '  nodetype_id   CHARACTER VARYING(30), '
       || '  id_element    CHARACTER VARYING(16), '
       || '  id_amsa       CHARACTER VARYING(30), '
       || '  expl_id       INTEGER '  
       || '  )';

  RAISE NOTICE USING MESSAGE = 'v_edit_man_conduit >> ';

  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn (nodetype_id, id_element, id_amsa, expl_id) '
      ||  'SELECT ''TRAM'', arc_id, code, expl_id FROM ' || schema1 || '.v_edit_man_conduit '
      ||  'ORDER BY expl_id, CAST(arc_id AS INTEGER)';

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    AND  table_name LIKE 'v_edit_man_%'
    AND  table_name NOT LIKE 'v_edit_%_pol'
    AND  table_name NOT IN ('v_edit_man_conduit', 'v_edit_man_siphon', 'v_edit_man_varc', 'v_edit_man_waccel',
                            'v_edit_man_connec','v_edit_man_gully')
  LOOP
    RAISE NOTICE USING MESSAGE = rec.table_name || ' >>';
    sql_insert := 'INSERT INTO ' || schema1 || '.amsa_urn(nodetype_id, id_element, id_amsa, expl_id) ' 
               || 'SELECT node_type, node_id, code, expl_id FROM ' || schema1 || '.' || rec.table_name || ' '
               || 'ORDER BY expl_id, CAST(node_id AS INTEGER)';
    EXECUTE sql_insert;
  END LOOP;

  RAISE NOTICE USING MESSAGE = 'v_edit_man_connec >> ';

  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn (nodetype_id, id_element, id_amsa, expl_id) '
      ||  'SELECT connec_type, connec_id, code, expl_id FROM ' || schema1 || '.v_edit_man_connec '
      ||  'ORDER BY expl_id, CAST(connec_id AS INTEGER)';

  RAISE NOTICE USING MESSAGE = 'v_edit_man_gully >> ';

  EXECUTE 'INSERT INTO ' || schema1 || '.amsa_urn (nodetype_id, id_element, id_amsa, expl_id) '
      ||  'SELECT gully_type, gully_id, code, expl_id FROM ' || schema1 || '.v_edit_man_gully '
      ||  'ORDER BY expl_id, CAST(gully_id AS INTEGER)';



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






CREATE OR REPLACE FUNCTION ud_migra.urn_set() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  RAISE NOTICE USING MESSAGE = 'v_edit_man_conduit >> ';

  EXECUTE 'UPDATE ' || schema1 || '.v_edit_man_conduit '
       || '   SET arc_id = id_nou '
       || 'FROM   ' || schema1 || '.amsa_urn '
       || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ''TRAM'' '
       || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_conduit.arc_id '
       || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_conduit.code '
       || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.v_edit_man_conduit.expl_id';

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    AND  table_name LIKE 'v_edit_man_%'
    AND  table_name NOT LIKE 'v_edit_%_pol'
    AND  table_name NOT IN ('v_edit_man_conduit', 'v_edit_man_siphon', 'v_edit_man_varc', 'v_edit_man_waccel',
                            'v_edit_man_connec',  'v_edit_man_gully')
  LOOP
    RAISE NOTICE USING MESSAGE = rec.table_name || ' >>';
    sql_update := 'UPDATE ' || schema1 || '.' || rec.table_name || ' '
               || '   SET node_id = id_nou '
               || 'FROM   ' || schema1 || '.amsa_urn '
               || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.' || rec.table_name || '.node_type '
               || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.' || rec.table_name || '.node_id '
               || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.' || rec.table_name || '.code '
               || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.' || rec.table_name || '.expl_id';
    EXECUTE sql_update;
  END LOOP;

  RAISE NOTICE USING MESSAGE = 'v_edit_man_connec >> ';

  EXECUTE 'UPDATE ' || schema1 || '.v_edit_man_connec '
       || '   SET connec_id = id_nou '
       || 'FROM   ' || schema1 || '.amsa_urn '
       || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_connec.connec_type '
       || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_connec.connec_id '
       || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_connec.code '
       || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.v_edit_man_connec.expl_id';

  RAISE NOTICE USING MESSAGE = 'v_edit_man_gully >> ';

  EXECUTE 'UPDATE ' || schema1 || '.v_edit_man_gully '
       || '   SET gully_id = id_nou '
       || 'FROM   ' || schema1 || '.amsa_urn '
       || 'WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_gully.gully_type '
       || '  AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_gully.gully_id '
       || '  AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_gully.code '
       || '  AND  ' || schema1 || '.amsa_urn.expl_id     = ' || schema1 || '.v_edit_man_gully.expl_id';
  
  RETURN 'Taules actualitzades amb el nou id';
END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ud_migra.urn_set_linked() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  recompte          INTEGER;
  compt             INTEGER := 0;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  -- CONNEC    FEATURE_ID    CL_V_CLAVEGUERO.ID_NODE/ID_TRAM

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_connec '
             || '    SET feature_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_connec.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_connec.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_connec.featurecat_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_connec >> Valors NODE actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.connec SET arc_id = feature_id WHERE featurecat_id = ''TRAM'' AND feature_id IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'connec >> Valors ARC_ID actualitzats : ' || recompte;

  compt := compt + 1;  
/*

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_connec '
             || '    SET feature_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_connec.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_connec.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_connec.code '
             || '    AND  ' || schema1 || '.v_edit_man_connec.featurecat_id = ''TRAM'' ';
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_connec >> Valors TRAM actualitzats : ' || recompte;

  compt := compt + 1;  
*/

  -- GULLY    FEATURE_ID    CL_V_EMBORNAL/REIXA.ID_NODE/ID_TRAM

/*
 || '    AND  ' || schema1 || '.v_edit_man_gully.featurecat_id NOT IN (''TRAM'',''EMBORNAL'',''REIXA'') '
*/

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_gully '
             || '    SET feature_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_gully.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_gully.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_gully.featurecat_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_gully >> Valors NODE actualitzats : ' || recompte;

sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.gully SET arc_id = feature_id WHERE featurecat_id = ''TRAM'' AND feature_id IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'gully >> Valors ARC_ID actualitzats : ' || recompte;

  compt := compt + 1;  

/*
  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_gully '
             || '    SET feature_id = id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_man_gully.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_gully.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_gully.code '
             || '    AND  ' || schema1 || '.v_edit_man_gully.featurecat_id = ''TRAM'' ';
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_gully >> Valors TRAM actualitzats : ' || recompte;

  compt := compt + 1;  
*/

  -- SAMPLEPOINT  FEATURE_ID    CL_V_MOSTREIG.ID_NODE/ID_TRAM

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_samplepoint '
             || '     SET feature_id = ' || schema1   || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_samplepoint.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_samplepoint.feature_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ' || schema1 || '.v_edit_samplepoint.featurecat_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_samplepoint >> Valors actualitzats : ' || recompte;

  compt := compt + 1;  



  RETURN 'Taules amb connec_id actualitzats \n  amb el nou id';
  
END
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION ud_migra.urn_set_arcnodes() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  recompte          INTEGER;
  compt             INTEGER := 0;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

/*
-- ** PROVISIONAL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_conduit SET node_1 = NULL WHERE node_1 LIKE ''zERR%'' ';
  EXECUTE sql_update;
  sql_update := 'UPDATE ' || schema1 || '.v_edit_man_conduit SET node_2 = NULL WHERE node_2 LIKE ''zERR%'' ';
  EXECUTE sql_update;

-- ** PROVISIONAL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_conduit '
             || '     SET node_1 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_conduit.node_1 '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_conduit.node_1 '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id NOT IN (''TRAM'',''EMBORNAL'',''REIXA'') '
             || '    AND  ' || schema1 || '.v_edit_man_conduit.node_1 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_conduit [ NODE_1 ] >> Valors actualitzats : ' || recompte;

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_conduit '
             || '     SET node_2 = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.v_edit_man_conduit.node_2 '
             || '    AND  ' || schema1 || '.amsa_urn.id_amsa     = ' || schema1 || '.v_edit_man_conduit.node_2 '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id NOT IN (''TRAM'',''EMBORNAL'',''REIXA'') '
             || '    AND  ' || schema1 || '.v_edit_man_conduit.node_2 IS NOT NULL '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_conduit [ NODE_2 ] >> Valors actualitzats : ' || recompte;

  RETURN 'Nodes inicials i finals de conduit actualitzats amb el nou id';
  
END
$$ LANGUAGE plpgsql;



/*
CREATE OR REPLACE FUNCTION ud_migra.urn_set_addfields() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_insert        TEXT;
  sql_truncate      TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
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
*/




CREATE OR REPLACE FUNCTION ud_migra.urn_set_rev_tables() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  -- ARCS (CONDUIT)

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_conduit '
             || '     SET arc_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_conduit.arc_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_conduit.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_conduit.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''ESCOMESA'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_conduit >> Valors actualitzats : ' || recompte;

  -- CONNEC

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_connec '
             || '     SET connec_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_connec.connec_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_connec.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_connec.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id = ''CLAVEGUERO'' '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_connec >> Valors actualitzats : ' || recompte;

  -- GULLY

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_gully '
             || '     SET gully_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_gully.gully_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_gully.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_gully.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''EMBORNAL'', ''REIXA'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_gully >> Valors actualitzats : ' || recompte;

  -- NODES (CHAMBER, JUNCTION, MANHOLE, NETINIT, OUTFALL, VALVE)

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_chamber '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_chamber.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_chamber.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_chamber.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''BOMBAMENT'', ''CAMBRA'', ''SOBREEIXIDOR'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_chamber >> Valors actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_junction '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_junction.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_junction.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_junction.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''UNIO'', ''NFICTICI'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_junction >> Valors actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_manhole '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_manhole.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_manhole.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_manhole.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''REGISTRE'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_manhole >> Valors actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_netinit '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_netinit.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_netinit.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_netinit.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''INICI'', ''SORRER'', ''SUMIDERO'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_netinit >> Valors actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_outfall '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_outfall.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_outfall.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_outfall.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''DESGUAS'', ''DESCARREGA'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_outfall >> Valors actualitzats : ' || recompte;


  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.amsa_rev_t_node_valve '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  CAST(' || schema1 || '.amsa_rev_t_node_valve.node_id AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_element '
             || '    AND  CAST(' || schema1 || '.amsa_rev_t_node_valve.code AS VARCHAR(16)) = ' || schema1 || '.amsa_urn.id_amsa '
             || '    AND  ' || schema1 || '.amsa_rev_t_node_valve.expl_id = ' || schema1 || '.amsa_urn.expl_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id IN (''VALVULA'', ''VENTOSA'', ''VRETENCIO'') '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';

  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'amsa_rev_t_node_valve >> Valors actualitzats : ' || recompte;


  RETURN 'Taules de revisió actualitzades amb el nou id';
  
END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ud_migra.urn_set_elements() 
RETURNS TEXT AS $$
DECLARE
  recompte          INTEGER;
  sql_update        TEXT;
  schema1 CONSTANT  TEXT := 'ud_migra';
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
             || '  UPDATE ' || schema1 || '.element_x_node '
             || '     SET node_id = ' || schema1 || '.amsa_urn.id_nou '
             || '  FROM   ' || schema1 || '.amsa_urn '
             || '  WHERE  ' || schema1 || '.amsa_urn.id_element  = ' || schema1 || '.element_x_node.node_id '
             || '    AND  ' || schema1 || '.amsa_urn.nodetype_id NOT IN (''TRAM'',''EMBORNAL'',''REIXA'') '
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


  RETURN 'Taules de relació element - node/connec actualitzades amb el nou id';
  
END
$$ LANGUAGE plpgsql;

  


CREATE OR REPLACE FUNCTION ud_migra.to_link( option TEXT ) 
RETURNS TEXT AS $$
DECLARE
  sql_truncate      TEXT;
  sql_create        TEXT;
  sql_update        TEXT;
  recompte          INTEGER;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  sql_truncate := 'TRUNCATE ' || schema1 || '.amsa_' || option || '_to_link';
  EXECUTE sql_truncate;

  sql_create := 'INSERT INTO ' || schema1 || '.amsa_' || option || '_to_link '
             || '  SELECT ' || option || '_id, v_edit_man_' || option || '.the_geom ' || option || '_geom, '
             || '         link_id, ST_StartPoint(v_edit_link.the_geom) first_vtx, ST_EndPoint(v_edit_link.the_geom) end_vtx, '
             || '         ST_ClosestPoint(v_edit_link.the_geom, v_edit_man_' || option || '.the_geom) as closest_pnt, CAST(null AS VARCHAR(3)) sel_vtx '
             || '  FROM ' || schema1 || '.v_edit_man_' || option || ',' || schema1 || '.v_edit_link '
             || '  WHERE ST_DWithin(v_edit_link.the_geom, v_edit_man_' || option || '.the_geom, 0.2)';
  EXECUTE sql_create;

  -- Identifica els casos en que closest_pnt és més a prop del vèrtex final que de l'inicial i després els canvia de sentit

--  EXECUTE 'ALTER TABLE ud_migra.amsa_connec_to_link ALTER COLUMN sel_vtx SET DATA TYPE VARCHAR(3)';

  sql_update := 'UPDATE ' || schema1 || '.amsa_' || option || '_to_link '
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
             || '    FROM   ' || schema1 || '.amsa_' || option || '_to_link '
             || '    WHERE  sel_vtx = ''END'' '
             || '  ) '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_link >> Corregides les direccions de les connexions : ' || recompte;

  -- Ajusta els nodes a l'extrem inicial del link

  sql_update := 'WITH rows AS ( '
             || '  UPDATE ' || schema1 || '.v_edit_man_' || option || ' '
             || '     SET the_geom = CASE '
             || '                   WHEN sel_vtx = ''END'' THEN ' || schema1 || '.amsa_' || option || '_to_link.end_vtx '
             || '                   ELSE ' || schema1 || '.amsa_' || option || '_to_link.first_vtx '
             || '                END '
             || '  FROM   ' || schema1 || '.amsa_' || option || '_to_link '
             || '  WHERE  ' || schema1 || '.v_edit_man_' || option || '.' || option || '_id = ' || schema1 || '.amsa_' || option || '_to_link.' || option || '_id '
             || '  RETURNING 1) '
             || 'SELECT count(*) FROM rows';
  EXECUTE sql_update INTO recompte;
  RAISE NOTICE USING MESSAGE = 'v_edit_man_' || option || ' >> Posicions corregides sobre v_edit_link : ' || recompte;              


  RETURN 'Corregides les posicions dels ' || option || ' sobre els links';
  
END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ud_migra.set_values() 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  schema1 CONSTANT  TEXT := 'ud_migra';
BEGIN

  -- S'assigna el valor comú inicial a dma_id

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name like 'v_edit_%'
      AND  table_name NOT IN ('v_edit_man_conduit','v_edit_dimensions','v_edit_element')
      AND  table_name NOT LIKE ('%_pol%')
  LOOP
    EXECUTE 'UPDATE ' || schema1 || '.' || rec.table_name || ' SET dma_id = 0';
  END LOOP;

/*
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
*/
  RETURN 'Corregits els valors per defecte de dma_id';

END
$$ LANGUAGE plpgsql;

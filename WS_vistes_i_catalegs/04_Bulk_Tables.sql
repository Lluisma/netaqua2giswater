


CREATE OR REPLACE FUNCTION ws_migra.bulk_prepare( schema TEXT )
RETURNS TEXT AS $$
DECLARE
  sql_create        TEXT;
BEGIN
  
  -- DESACTIVA ELS TRIGGERS DE CONTROL TOPOLÒGIC D'ARCS I NODES

  EXECUTE 'ALTER TABLE ' || schema || '.arc  DISABLE TRIGGER gw_trg_topocontrol_arc';
  EXECUTE 'ALTER TABLE ' || schema || '.node DISABLE TRIGGER gw_trg_topocontrol_node';
  EXECUTE 'ALTER TABLE ' || schema || '.node DISABLE TRIGGER gw_trg_node_update';

  -- CONFIGURACIÓ DE PARÀMETRES PER SIMPLIFICAR EL PROCÉS D'INSERCIÓ

  EXECUTE 'UPDATE ' || schema || '.config ' ||
          '   SET node_proximity_control = false, ' ||
          '       connec_proximity_control = false, ' ||
          '       arc_searchnodes_control = false ';

  -- CONFIGRUACIÓ DEL PARÀMETRE QUE DESHABILITA LA MODIFICACIÓ DE NODE_1 I NODE_2 DELS ARCS

  EXECUTE 'UPDATE ' || schema || '.config_param_system ' ||
          '   SET value = ''TRUE'' ' ||
          'WHERE  parameter = ''edit_enable_arc_nodes_update'' ';


--  -- MODIFICA EL TIPUS DE EXT_STREETAXIS DE LineString A MultiLineString I REFÀ LA VISTA V_EXT_EXTREETAXIS
--
--  EXECUTE 'DROP VIEW ' || schema  || '.v_ext_streetaxis';
--
--  EXECUTE 'ALTER TABLE ' || schema  || '.ext_streetaxis ALTER COLUMN the_geom SET DATA TYPE geometry(MultiLineString)';
--
--  sql_create := 'CREATE OR REPLACE VIEW ' || schema || '.v_ext_streetaxis AS ' ||
--                '  SELECT ext_streetaxis.id, ext_streetaxis.type, ext_streetaxis.name, ext_streetaxis.text, ext_streetaxis.the_geom, ' ||
--                '         ext_streetaxis.expl_id, ext_streetaxis.muni_id ' ||
--                '  FROM   ' || schema || '.selector_expl, ' || schema || '.ext_streetaxis ' ||
--                '  WHERE  ext_streetaxis.expl_id = selector_expl.expl_id AND selector_expl.cur_user = "current_user"()::text';
--  EXECUTE sql_create;

    
  RETURN 'Triggers desactivats | config values | ext_streetaxis a MultiLineString';

END
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION ws_migra.bulk_delete ( schema2 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_delete        TEXT;
  compt             INTEGER DEFAULT 0;
  schema1 CONSTANT  TEXT := 'ws_migra';
  StartTime         TIMESTAMP;
  EndTime           TIMESTAMP;

BEGIN

  StartTime := clock_timestamp();

  -- Elimina (si existeixen) les taules de catàlegs específics d'AMSA (amsa_cat)

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema2
      AND  table_name LIKE 'amsa_cat%'
  LOOP
    RAISE NOTICE USING MESSAGE = rec.table_name;
    sql_delete := 'DROP TABLE IF EXISTS ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_delete;
    RAISE NOTICE USING MESSAGE = '... dropped';
    compt := compt + 1;  

  END LOOP;

  -- Elimina el contingut de les taules genèriques i man_*

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema2
      AND  table_name IN ('arc', 'connec', 'node', 'element', 'link', 'pond', 'pool', 'samplepoint')
  LOOP
    RAISE NOTICE USING MESSAGE = rec.table_name;
    sql_delete := 'TRUNCATE ' || schema2 || '.' || rec.table_name || ' CASCADE';
    EXECUTE sql_delete;
    RAISE NOTICE USING MESSAGE = '... truncated';
    compt := compt + 1;  

  END LOOP;


  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema2
      AND  (table_name LIKE 'man_%' or table_name in ('inp_junction', 'inp_pipe', 'inp_pump', 'inp_source', 'inp_tank', 'inp_shortpipe','inp_valve'))
      AND  table_name NOT LIKE 'man_addfields_%'
      AND  table_name NOT LIKE 'man_type_%'
  LOOP
    RAISE NOTICE USING MESSAGE = rec.table_name;
    sql_delete := 'DELETE FROM ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_delete;
    RAISE NOTICE USING MESSAGE = '... deleted';
    compt := compt + 1;  

  END LOOP;


  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name NOT LIKE 'amsa%'
      AND  table_name NOT LIKE '%_pol'   
      AND  table_name NOT LIKE '%tmp%'
      AND  table_name NOT IN ('v_edit_man_pipe','v_edit_man_varc', 'v_edit_link')     -- S'inseriran al final
      AND  table_type = 'BASE TABLE'
    ORDER BY table_name 
  LOOP

    RAISE NOTICE USING MESSAGE = rec.table_name;

    IF substring(rec.table_name from 0 for 7)='v_edit' THEN
      sql_delete := 'DELETE FROM ' || schema2 || '.' || rec.table_name || ' CASCADE';
    ELSE 
      sql_delete := 'TRUNCATE ' || schema2 || '.' || rec.table_name || ' CASCADE';
    END IF;
    EXECUTE sql_delete;
    RAISE NOTICE USING MESSAGE = '... deleted';
    compt := compt + 1;  

  END LOOP;

  EndTime := clock_timestamp();


  RETURN compt || ' taules buides  (' || EXTRACT (SECONDS from(EndTime - StartTime))  || ' s)';

END
$$ LANGUAGE plpgsql;




-- ** DESACTIVA ELS TRIGGERS DE CONTROL TOPOLÒGIC D'ARCS I NODES


CREATE OR REPLACE FUNCTION ws_migra.bulk_notfk( schema2 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  r record;
  compt             INTEGER DEFAULT 0;
BEGIN

  FOR r IN (SELECT table_name, constraint_name 
            FROM   information_schema.table_constraints 
            WHERE  table_schema = schema2
              AND  constraint_type = 'FOREIGN KEY' ) LOOP
    
    EXECUTE 'ALTER TABLE ' || schema2 || '.' || r.table_name || ' DROP CONSTRAINT ' || r.constraint_name;
    RAISE INFO '%','dropping '||r.constraint_name;
    compt := compt + 1;  

  END LOOP;

  RETURN compt || ' constraints eliminades';

END
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION ws_migra.bulk_tables( schema2 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec      		      RECORD;
  sql_delete	      TEXT;
  sql_insert	      TEXT;
  sql_count         TEXT;
  total             INTEGER;
  titles    	      TEXT		DEFAULT 'Error';
  compt 	          INTEGER	DEFAULT 0;
  schema1	CONSTANT 	TEXT := 'ws_migra';
  StartTime         TIMESTAMP;
  IniTime           TIMESTAMP;
  EndTime           TIMESTAMP;

BEGIN

  StartTime := clock_timestamp();
 

  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name LIKE 'amsa_cat%'
    ORDER BY table_name 
  LOOP

    IniTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = rec.table_name;

    sql_insert := 'CREATE TABLE ' || schema2 || '.' || rec.table_name || ' AS SELECT * FROM ' || schema1 || '.' || rec.table_name;
    EXECUTE sql_insert;


    sql_count := 'SELECT COUNT(*) FROM ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_COUNT INTO total;

    EndTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

    compt := compt + 1;  

  END LOOP;


  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name NOT LIKE 'amsa%'                                                  -- amsa_cat_* es creen i insereixen abans
      AND  table_name NOT LIKE '%_pol'   
      AND  table_name NOT LIKE '%tmp%'
      --AND  table_name NOT LIKE 'cat%'                                                 -- S'insereixen abans
      --AND  table_name NOT LIKE 'value%'                                               -- S'insereixen abans
      AND  table_name NOT LIKE 'v_edit%'
      AND  table_type = 'BASE TABLE'
    ORDER BY table_name 
  LOOP

    IniTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = rec.table_name;

    sql_insert := 'INSERT INTO ' || schema2 || '.' || rec.table_name || 
                  ' SELECT * FROM ' || schema1 || '.' || rec.table_name;
    EXECUTE sql_insert;


    sql_count := 'SELECT COUNT(*) FROM ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_COUNT INTO total;

    EndTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

    compt := compt + 1;  

  END LOOP;


  FOR rec IN
    SELECT table_name 
    FROM   INFORMATION_SCHEMA.tables 
    WHERE  table_schema = schema1
      AND  table_name LIKE 'v_edit_%'
      AND  table_name NOT IN ('v_edit_man_pipe','v_edit_man_varc', 'v_edit_link')     -- S'inseriran al final
    ORDER BY table_name 
  LOOP

    IniTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = rec.table_name;

    sql_insert := 'INSERT INTO ' || schema2 || '.' || rec.table_name || 
                  ' SELECT * FROM ' || schema1 || '.' || rec.table_name;
    EXECUTE sql_insert;


    sql_count := 'SELECT COUNT(*) FROM ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_COUNT INTO total;

    EndTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

    compt := compt + 1;  

  END LOOP;


/*
  FOR rec IN
	  SELECT table_name 
	  FROM   INFORMATION_SCHEMA.tables 
	  WHERE  table_schema = schema1
      AND  table_name NOT LIKE 'amsa%'
      AND  table_name NOT LIKE '%_pol'   
      AND  table_name NOT LIKE '%tmp%'
      AND  table_name NOT LIKE 'cat%'                                                 -- S'insereixen abans
      AND  table_name NOT LIKE 'value%'                                               -- S'insereixen abans
      AND  table_name NOT IN ('v_edit_man_pipe','v_edit_man_varc', 'v_edit_link')     -- S'inseriran al final
	  ORDER BY table_name 
  LOOP

    IniTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = rec.table_name;

    sql_insert := 'INSERT INTO ' || schema2 || '.' || rec.table_name || 
                  ' SELECT * FROM ' || schema1 || '.' || rec.table_name;
    EXECUTE sql_insert;


    sql_count := 'SELECT COUNT(*) FROM ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_COUNT INTO total;

    EndTime := clock_timestamp();

    RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

    compt := compt + 1;  

  END LOOP;
*/  

  -- PIPE

  IniTime := clock_timestamp();

  RAISE NOTICE USING MESSAGE = 'v_edit_man_pipe';

  EXECUTE 'INSERT INTO ' || schema2 || '.v_edit_man_pipe SELECT * FROM ' || schema1 || '.v_edit_man_pipe';
  EXECUTE 'SELECT COUNT(*) FROM ' || schema2 || '.v_edit_man_pipe' INTO total;

  EndTime := clock_timestamp();
  RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

  compt := compt + 1;  


  -- VARC

  IniTime := clock_timestamp();

  RAISE NOTICE USING MESSAGE = 'v_edit_man_varc';

  EXECUTE 'INSERT INTO ' || schema2 || '.v_edit_man_varc SELECT * FROM ' || schema1 || '.v_edit_man_varc';
  EXECUTE 'SELECT COUNT(*) FROM ' || schema2 || '.v_edit_man_varc' INTO total;

  EndTime := clock_timestamp();
  RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

  compt := compt + 1;  


-- ************************************************************************************************    i
-- TODO: consultar a la tabla de link els que no tenen feature_type o tenen connec al final, i altres

  -- LINK

  IniTime := clock_timestamp();

  RAISE NOTICE USING MESSAGE = 'link';

  EXECUTE 'INSERT INTO ' || schema2 || '.v_edit_link SELECT * FROM ' || schema1 || '.v_edit_link WHERE link_id NOT IN (' ||
          ' SELECT link_id FROM ws_migra.amsa_ctrl_link_no_connec  )';
  EXECUTE 'SELECT COUNT(*) FROM ' || schema2 || '.v_edit_link' INTO total;

  EndTime := clock_timestamp();
  RAISE NOTICE USING MESSAGE = '     ' || total || '   (' || EXTRACT (SECONDS from(EndTime - IniTime))  || ' s)';

  compt := compt + 1;  


  -- Restableix els triggers

  EXECUTE 'ALTER TABLE ' || schema2 || '.arc ENABLE TRIGGER gw_trg_topocontrol_arc';
  EXECUTE 'ALTER TABLE ' || schema2 || '.node ENABLE TRIGGER gw_trg_topocontrol_node';
  EXECUTE 'ALTER TABLE ' || schema2 || '.node ENABLE TRIGGER gw_trg_node_update';

  RETURN compt || ' elements copiats (' || EXTRACT (SECONDS from(EndTime - StartTime))  || ' s)';

END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ws_migra.bulk_mincut_inlets( schema TEXT) 
RETURNS TEXT AS $$
DECLARE
  schema1 CONSTANT  TEXT := 'ws_migra';
BEGIN

  EXECUTE 'INSERT INTO ' || schema || '.anl_mincut_inlet_x_exploitation (node_id, expl_id) ' ||
          'SELECT node.node_id, expl_id ' ||
          'FROM   ' || schema || '.node JOIN ' || schema || '.man_tank ON man_tank.node_id=node.node_id';

  RETURN 'anl_mincut_inlet_x_exploitation actualitzada';

END
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION ws_migra.bulk_one_table( tablename TEXT, type_id TEXT, schema2 TEXT) 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_insert        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
  compt             INTEGER DEFAULT 0;
BEGIN
  FOR rec IN
    EXECUTE 'SELECT * FROM ' || schema1 || '.' || tablename
  LOOP

    IF type_id = 'arc' THEN 
        sql_insert := 'INSERT INTO ' || schema2 || '.' || tablename || ' ' 
                   || 'SELECT * '
                   || 'FROM ' || schema1 || '.' || tablename || ' '
                   || 'WHERE arc_id = ''' || rec.arc_id || '''';
    END IF;

    IF type_id = 'connec' THEN 
        sql_insert := 'INSERT INTO ' || schema2 || '.' || tablename || ' ' 
                   || 'SELECT * '
                   || 'FROM ' || schema1 || '.' || tablename || ' '
                   || 'WHERE connec_id = ''' || rec.connec_id || '''';
    END IF;
    
    IF type_id = 'node' THEN 
        sql_insert := 'INSERT INTO ' || schema2 || '.' || tablename || ' ' 
                   || 'SELECT * '
                   || 'FROM ' || schema1 || '.' || tablename || ' '
                   || 'WHERE node_id = ''' || rec.node_id || '''';
    END IF;

    compt := compt + 1;  

    RAISE NOTICE USING MESSAGE = compt || ' : ' || sql_insert;
    EXECUTE sql_insert;

  END LOOP;

  RETURN 'Taula ' || tablename  || ' copiada';

END
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION ws_migra.bulk_links( schema2 TEXT, start INTEGER DEFAULT 0 ) 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_insert        TEXT;
  schema1 CONSTANT  TEXT := 'ws_migra';
  compt             INTEGER DEFAULT 0;
BEGIN

  EXECUTE 'TRUNCATE ' || schema2 || '.link';

  FOR rec IN
    EXECUTE 'SELECT * FROM ' || schema1 || '.v_edit_link 
             WHERE  link_id NOT IN (SELECT link_id FROM ws_migra.amsa_ctrl_link_no_connec)
               AND  link_id > ' || start || '
             ORDER BY link_id'
  LOOP
               
--and link_id not in (10691,12502,12560,15145)
--                 ( 2845, 9351,12442, 3275)

    sql_insert := 'INSERT INTO ' || schema2 || '.v_edit_link '
               || 'SELECT * '
               || 'FROM ' || schema1 || '.v_edit_link '
               || 'WHERE link_id = ' || rec.link_id;
               
    RAISE NOTICE USING MESSAGE = sql_insert;
    EXECUTE sql_insert;
    compt := compt + 1;  

  END LOOP;

  RETURN compt || ' links copiats';

END
$$ LANGUAGE plpgsql;
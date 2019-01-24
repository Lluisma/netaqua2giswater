
-- Replica vistes i taules catàleg a l’esquema migra


-- VISTES EDITABLES (V_EDIT_MAN_*) + SAMPLEPOINT / DIMENSIONS / ELEMENT / LINK / NODE 

CREATE OR REPLACE FUNCTION ud_migra.generate_views( schema1 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec 		          RECORD;
  sql_drop	        TEXT;
  sql_crea	        TEXT;
  sql_alter         TEXT;
  titles    	      TEXT    DEFAULT 'Error';
  compt 	          INTEGER DEFAULT 0;
  schema2	CONSTANT 	TEXT := 'ud_migra';
BEGIN
  FOR rec IN
	SELECT table_name 
	FROM   INFORMATION_SCHEMA.views 
	WHERE  table_schema = 'ud'
	  AND  (   table_name LIKE 'v_edit_man_%'
	        or table_name IN ('v_edit_samplepoint', 'v_edit_dimensions', 'v_edit_element', 'v_edit_link', 'v_edit_vnode'))
	  AND  table_name NOT LIKE '%pol'
		ORDER BY table_name
  LOOP
    
    sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.' || rec.table_name || ' CASCADE';
    EXECUTE sql_drop;
    
    sql_crea := 'CREATE TABLE ' || schema2 || '.' || rec.table_name || 
                ' AS SELECT * FROM ' || schema1 || '.' || rec.table_name || 
                ' WHERE 1=2';
    EXECUTE sql_crea;

    RAISE NOTICE USING MESSAGE = rec.table_name;

    compt := compt + 1;  

  END LOOP;

  -- Els camps node_1/node_2 apleguen provisionalment (abans de urn_set) el parell tipus/codi dels nodes incial i final


  --EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_no_geom ';
  --EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_link_no_connec ';
  --EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_arcnode_error ';
  

  EXECUTE 'ALTER TABLE ' || schema2  || '.man_type_category ALTER COLUMN featurecat_id SET DATA TYPE CHARACTER VARYING(50)';

  --sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_1 SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;
  --sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_2 SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;
  --
  --sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_1 SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;
  --sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_2 SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;
  --
  --sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_connec ALTER COLUMN connec_id SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;
  --sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_node ALTER COLUMN node_id SET DATA TYPE CHARACTER VARYING(20)';
  --EXECUTE sql_alter;  

  RETURN compt || ' vistes generades';

END
$$ LANGUAGE plpgsql;


-- TAULES               ARC_TYPE / CONNECT_TYPE / GULLY_TYPE / NODE_TYPE / ELEMENT_*  +  EXPLOITATION / SECTOR / DMA / MACRODMA / PLAN_PSECTOR
-- DADES ADDICIONALS    MAN_ADDFIELDS_*
-- CATÀLEGS             CAT_* / MAN_TYPE_* / VALUE_* / -- EXT_* (EXCEPTE EXT_RTC_* / EXT_CAT_*)
-- CATÀLEGS ESPECÍFICS  AMSA_*

CREATE OR REPLACE FUNCTION ud_migra.generate_catalogs( schema1 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec               RECORD;
  sql_drop          TEXT;
  sql_crea          TEXT;
  sql_alter         TEXT;
  titles            TEXT    DEFAULT 'Error';
  compt             INTEGER DEFAULT 0;
  schema2 CONSTANT  TEXT := 'ud_migra';
BEGIN

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    AND  (   table_name LIKE 'cat_%'
          OR table_name LIKE 'element_%' 
          --OR (table_name LIKE 'ext_%' and table_name not like 'ext_rtc_%' and table_name not like 'ext_cat_%')
          OR table_name LIKE 'man_type_%' 
          OR table_name LIKE 'man_addfields_%' 
          OR table_name LIKE 'value_%' 
          OR table_name IN ('arc_type', 'connec_type', 'element_type', 'gully_type', 'node_type')
          OR table_name IN ('exploitation', 'macroexploitation', 'sector', 'macrosector', 'dma', 'macrodma', 'subcatchment', 'plan_psector')
          OR table_name IN ('selector_expl', 'selector_state', 'config_param_user')
               )
    ORDER BY table_name
  LOOP
    sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_drop;
    sql_crea := 'CREATE TABLE ' || schema2 || '.' || rec.table_name || 
                ' AS SELECT * FROM ' || schema1 || '.' || rec.table_name || 
                ' WHERE 1=2';
    EXECUTE sql_crea;
    RAISE NOTICE USING MESSAGE = rec.table_name;
    compt := compt + 1;  
  END LOOP;

/*
  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.man_addfields_value_tmp';
  EXECUTE sql_drop;
  sql_crea := 'CREATE TABLE ' || schema2  || '.man_addfields_value_tmp ( ' ||
              '  id              DOUBLE PRECISION, ' ||
              '  feature_id      DOUBLE PRECISION, ' ||
              '  parameter_id    DOUBLE PRECISION, ' ||
              '  value_param     VARCHAR(240), ' ||
              '  expl_id         DOUBLE PRECISION, ' ||
              '  featurecat_id   VARCHAR(8), ' ||
              '  id_amsa         DOUBLE PRECISION ' ||
              ')';
  EXECUTE sql_crea;
*/
  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_eixos_shp';
  EXECUTE sql_drop;
  sql_crea := 'CREATE TABLE ' || schema2  || '.amsa_eixos_shp ( ' ||
              '  EIX_CARRER  TEXT, ' ||
              '  CARRER_ID   DOUBLE PRECISION, ' ||
              '  CARRER_NOM  TEXT, ' ||
              '  DATA_ACTU   TEXT ' ||
              ')';
  EXECUTE sql_crea;
  sql_crea := 'SELECT AddGeometryColumn(''' || schema2 || ''',''amsa_eixos_shp'',''the_geom'',25831,''MULTILINESTRING'',2)';
  EXECUTE sql_crea;


  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_connec_to_link';
  EXECUTE sql_drop;
  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_connec_to_link ( ' ||
              '  connec_id     character varying(16), ' ||
              '  connec_geom   geometry(Point,25831), ' ||
              '  link_id       integer, ' ||
              '  first_vtx     geometry, ' ||
              '  end_vtx       geometry, ' ||
              '  closest_pnt   geometry, ' ||
              '  sel_vtx       character varying(3) ' ||
              ')';
  EXECUTE sql_crea;

  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_gully_to_link';
  EXECUTE sql_drop;
  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_gully_to_link ( ' ||
              '  gully_id      character varying(16), ' ||
              '  gully_geom    geometry(Point,25831), ' ||
              '  link_id       integer, ' ||
              '  first_vtx     geometry, ' ||
              '  end_vtx       geometry, ' ||
              '  closest_pnt   geometry, ' ||
              '  sel_vtx       character varying(3) ' ||
              ')';
  EXECUTE sql_crea;


  --sql_alter := 'ALTER TABLE ' || schema2  || '.ext_streetaxis ALTER COLUMN the_geom SET DATA TYPE geometry(MultiLineString)';
  --EXECUTE sql_alter;


  RETURN (compt) || ' + 3 catàlegs generats';

END
$$ LANGUAGE plpgsql;




SELECT ud_migra.generate_views( 'ud' );
SELECT ud_migra.generate_catalogs( 'ud' );


--

--ALTER TABLE ud_migra.v_edit_man_pipe ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ud_migra.v_edit_man_pipe ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ud_migra.v_edit_man_varc ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ud_migra.v_edit_man_varc ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ud_migra.element_x_connec ALTER COLUMN connec_id SET DATA TYPE VARCHAR(20);
--ALTER TABLE ud_migra.element_x_node ALTER COLUMN node_id SET DATA TYPE VARCHAR(20);




-- VISTES DE REVISIÓ I CONTORL (DEPENDENTS DE LES TAULES ANTERIORS)

/*
CREATE OR REPLACE VIEW ud_migra.amsa_ctrl_arcnode_error AS
  SELECT CODE AS ID_TRAM, NODE_1, NODE_2, EXPL_ID
  FROM   ud_migra.v_edit_man_conduit
  WHERE  (node_1 like '%TAP%' or node_2 like '%TAP%')
  ORDER BY CAST(CODE AS INTEGER);
*/


CREATE OR REPLACE VIEW ud_migra.amsa_ctrl_link_no_connec AS
  SELECT * 
  FROM   ud_migra.v_edit_link
  WHERE  link_id NOT IN(
    SELECT link_id FROM ud_migra.amsa_connec_to_link
  )
  ORDER BY link_id;


-- connecs i gullies en altat amb dades de tram/node assignat però sense link dibuixat

CREATE OR REPLACE VIEW ud_migra.amsa_ctrl_connec_gully_no_link AS
  SELECT 'GULLY' tipus, t1.gully_id, t1.code, t1.gully_type, t1.state, t1.feature_id, t1.featurecat_id
  FROM   ud.gully t1
  WHERE  t1.gully_id NOT IN (
    SELECT t1.gully_id
    FROM   ud.gully t1, ud.link t2
    WHERE  st_dwithin(t1.the_geom, t2.the_geom,0.05)
      AND  (t1.state=1 or t1.state=2)
      AND  t1.feature_id IS NOT NULL
  )
  AND    featurecat_id IS NOT NULL
  UNION  
  SELECT 'CONNEC', t1.connec_id, t1.code, t1.connec_type, t1.state, t1.feature_id, t1.featurecat_id
  FROM   ud.connec t1
  WHERE  t1.connec_id NOT IN (
    SELECT t1.connec_id
    FROM   ud.connec t1, ud.link t2
    WHERE  st_dwithin(t1.the_geom, t2.the_geom,0.1)
    AND  (t1.state=1 or t1.state=2)
    AND  t1.feature_id IS NOT NULL
  )
  AND    featurecat_id IS NOT NULL
  ORDER BY tipus, state, code;



CREATE OR REPLACE VIEW ud_migra.amsa_ctrl_no_geom AS

  SELECT 'LINK' TIPUS, LINK_ID::character varying(6) CODE, EXPL_ID FROM ud_migra.v_edit_link WHERE the_geom IS NULL
  UNION
  SELECT 'CHAMBER' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_chamber WHERE the_geom IS NULL
  UNION
  SELECT 'CONDUIT' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_conduit WHERE the_geom IS NULL
  UNION
  SELECT 'CONNEC' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_connec WHERE the_geom IS NULL
  UNION
  SELECT 'GULLY' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_gully WHERE the_geom IS NULL
  UNION
  SELECT 'GULLY_POL' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_gully WHERE the_geom IS NULL
  UNION
  SELECT 'JUNCTION' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_junction WHERE the_geom IS NULL
  UNION
  SELECT 'MANHOLE' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_manhole WHERE the_geom IS NULL
  UNION
  SELECT 'NETELEMENT' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_netelement WHERE the_geom IS NULL
  UNION
  SELECT 'NETGULLY' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_netgully WHERE the_geom IS NULL
  UNION
  SELECT 'NETINIT' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_netinit WHERE the_geom IS NULL
  UNION
  SELECT 'OUTFALL' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_outfall WHERE the_geom IS NULL
  UNION
  SELECT 'SIPHON' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_siphon WHERE the_geom IS NULL
  UNION
  SELECT 'STORAGE' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_storage WHERE the_geom IS NULL
  UNION
  SELECT 'VALVE' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_valve WHERE the_geom IS NULL
  UNION
  SELECT 'VARC' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_varc WHERE the_geom IS NULL
  UNION
  SELECT 'WACCEL' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_waccel WHERE the_geom IS NULL
  UNION
  SELECT 'WJUMP' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_wjump WHERE the_geom IS NULL
  UNION
  SELECT 'WWTP' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_man_wwtp WHERE the_geom IS NULL
  UNION
  SELECT 'SAMPLEPOINT' TIPUS, CODE, EXPL_ID FROM ud_migra.v_edit_samplepoint WHERE the_geom IS NULL
  ORDER BY TIPUS, CODE;



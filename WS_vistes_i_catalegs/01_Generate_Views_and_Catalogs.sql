
-- Replica vistes i taules catàleg a l’esquema migra


-- VISTES EDITABLES (V_EDIT_MAN_*) + SAMPLEPOINT / POND / POOL / DIMENSIONS / ELEMENT / LINK / NODE 

CREATE OR REPLACE FUNCTION ws_migra.generate_views( schema1 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec 		          RECORD;
  sql_drop	        TEXT;
  sql_crea	        TEXT;
  sql_alter         TEXT;
  titles    	      TEXT		DEFAULT 'Error';
  compt 	          INTEGER	DEFAULT 0;
  schema2	CONSTANT 	TEXT := 'ws_migra';
BEGIN
  FOR rec IN
	SELECT table_name 
	FROM   INFORMATION_SCHEMA.views 
	WHERE  table_schema = 'ws'
	  AND  (   table_name like 'v_edit_man_%'
	        or table_name in ('v_edit_samplepoint', 'v_edit_pond', 'v_edit_pool', 
                            'v_edit_dimensions', 'v_edit_element', 'v_edit_link', 'v_edit_vnode'))
		ORDER BY table_name
  LOOP
    
    sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.' || rec.table_name || ' CASCADE';
    EXECUTE sql_drop;
    
    sql_crea := 'CREATE TABLE ' || schema2 || '.' || rec.table_name || 
                ' AS SELECT * FROM ' || schema1 || '.' || rec.table_name || 
                ' WHERE 1=2';
    EXECUTE sql_crea;

    compt := compt + 1;  

  END LOOP;

  -- Els camps node_1/node_2 apleguen provisionalment (abans de urn_set) el parell tipus/codi dels nodes incial i final


  EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_no_geom ';
  EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_link_no_connec ';
  EXECUTE 'DROP VIEW IF EXISTS ' || schema2 || '.amsa_ctrl_arcnode_error ';
 
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_1 SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_2 SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;

  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_1 SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_2 SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;

  sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_connec ALTER COLUMN connec_id SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_node ALTER COLUMN node_id SET DATA TYPE CHARACTER VARYING(20)';
  EXECUTE sql_alter;  

  RETURN compt || ' vistes generades';

END
$$ LANGUAGE plpgsql;


-- TAULES   ARC_TYPE / CONNECT_TYPE / NODE_TYPE / ELEMENT_*  +  EXPLOITATION / SECTOR / DMA / MACRODMA 
-- MAN_ADDFIELDS_VALUE_TMP
-- CATÀLEGS CAT_* / MAN_TYPE_* / VALUE_* 
-- CATÀLEGS ESPECÍFICS AMSA_*

CREATE OR REPLACE FUNCTION ws_migra.generate_catalogs( schema1 TEXT ) 
RETURNS TEXT AS $$
DECLARE
  rec     RECORD;
  sql_drop  TEXT;
  sql_crea  TEXT;
  sql_alter TEXT;
  titles      TEXT    DEFAULT 'Error';
  compt   INTEGER DEFAULT 0;
  schema2 CONSTANT  TEXT := 'ws_migra';
BEGIN

  FOR rec IN
  SELECT table_name 
  FROM   INFORMATION_SCHEMA.tables 
  WHERE  table_schema = schema1
    AND  (   table_name like 'cat_%'
          or table_name like 'element_%' 
          --or (table_name like 'ext_%' and table_name not like 'ext_rtc_%' and table_name not like 'ext_cat_%')
          or table_name like 'man_type_%' 
          or table_name like 'man_addfields_%' 
          or table_name like 'value_%' 
          or table_name in ('arc_type', 'connec_type', 'element_type', 'node_type')
          or table_name in ('exploitation', 'macroexploitation', 'sector', 'macrosector', 'dma', 'macrodma', 'plan_psector')
          or table_name in ('selector_expl', 'selector_state', 'selector_hydrometer', 'config_param_user')
          or table_name like 'anl_mincut_cat_%'
          or table_name in ('anl_mincut_inlet_x_exploitation', 'anl_mincut_result_cat', 'anl_mincut_result_connec',
                            'anl_mincut_selector_valve', 'anl_mincut_result_hydrometer')
               )
    ORDER BY table_name
  LOOP
    sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.' || rec.table_name;
    EXECUTE sql_drop;
    sql_crea := 'CREATE TABLE ' || schema2 || '.' || rec.table_name || 
                ' AS SELECT * FROM ' || schema1 || '.' || rec.table_name || 
                ' WHERE 1=2';
    EXECUTE sql_crea;
    compt := compt + 1;  
  END LOOP;


  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.man_addfields_value_tmp';
  EXECUTE sql_drop;
  sql_crea := 'CREATE TABLE ' || schema2  || '.man_addfields_value_tmp ( ' ||
              '  id              DOUBLE PRECISION, ' ||
              '  feature_id      DOUBLE PRECISION, ' ||
              '  parameter_id    DOUBLE PRECISION, ' ||
              '  value_param     VARCHAR(240), ' ||
              '  expl_id         DOUBLE PRECISION, ' ||
              '  featurecat_id   VARCHAR(30), ' ||
              '  id_amsa         DOUBLE PRECISION ' ||
              ')';
  EXECUTE sql_crea;

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


  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_cat_font_continuous CASCADE';
  EXECUTE sql_drop;
  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_cat_font_arq_valv CASCADE';
  EXECUTE sql_drop;
    sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_cat_pcar_racor_diam CASCADE';
  EXECUTE sql_drop;
  sql_drop := 'DROP TABLE IF EXISTS ' || schema2 || '.amsa_cat_pipe_inv_tipus CASCADE';
  EXECUTE sql_drop;

  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_cat_font_continuous ( ' ||
              '  ID_FONT_CONTINUOUS VARCHAR(2), ' ||
              '  VALUE_FONT_CONTINUOUS VARCHAR(15) ' ||
              ')';
  EXECUTE sql_crea;

  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_cat_font_arq_valv ( ' ||
              '  ID_FONT_ARQ_VALV VARCHAR(2), ' ||
              '  VALUE_FONT_ARQ_VALV VARCHAR(10) ' ||
              ')';
  EXECUTE sql_crea;

  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_cat_pcar_racor_diam ( ' ||
              '  ID_PCAR_RACOR_DIAM BIGINT ' ||
              ')';
  EXECUTE sql_crea;

  sql_crea := 'CREATE TABLE ' || schema2 || '.amsa_cat_pipe_inv_tipus ( ' ||
              '  ID_INV_TIPUS VARCHAR(10), ' ||
              '  VALUE_INV_TIPUS VARCHAR(70) ' ||
              ')';
  EXECUTE sql_crea;


  --sql_alter := 'ALTER TABLE ' || schema2  || '.ext_streetaxis ALTER COLUMN the_geom SET DATA TYPE geometry(MultiLineString)';
  --EXECUTE sql_alter;



  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_pipe ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.v_edit_man_varc ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_connec ALTER COLUMN connec_id SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;
  sql_alter := 'ALTER TABLE ' || schema2  || '.element_x_node ALTER COLUMN node_id SET DATA TYPE VARCHAR(20)';
  EXECUTE sql_alter;



  RETURN (compt+2) || ' catàlegs generats';

END
$$ LANGUAGE plpgsql;




SELECT ws_migra.generate_views( 'ws' );
SELECT ws_migra.generate_catalogs( 'ws' );


--

--ALTER TABLE ws_migra.v_edit_man_pipe ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ws_migra.v_edit_man_pipe ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ws_migra.v_edit_man_varc ALTER COLUMN node_1 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ws_migra.v_edit_man_varc ALTER COLUMN node_2 SET DATA TYPE VARCHAR(20);
--ALTER TABLE ws_migra.element_x_connec ALTER COLUMN connec_id SET DATA TYPE VARCHAR(20);
--ALTER TABLE ws_migra.element_x_node ALTER COLUMN node_id SET DATA TYPE VARCHAR(20);


-- VISTES DE REVISIÓ I CONTORL (DEPENDENTS DE LES TAULES ANTERIORS)


CREATE OR REPLACE VIEW ws_migra.amsa_ctrl_arcnode_error AS
  SELECT CODE AS ID_TRAM, NODE_1, NODE_2, EXPL_ID
  FROM   WS_MIGRA.V_EDIT_MAN_PIPE
  WHERE  (node_1 like '%TAP%' or node_2 like '%TAP%')
  ORDER BY CAST(CODE AS INTEGER);



CREATE OR REPLACE VIEW ws_migra.amsa_ctrl_link_no_connec AS
  SELECT * 
  FROM   ws_migra.v_edit_link
  WHERE  link_id NOT IN(
    SELECT link_id FROM ws_migra.amsa_connec_to_link
  )
  ORDER BY link_id;



CREATE OR REPLACE VIEW ws_migra.amsa_ctrl_no_geom AS

  SELECT 'LINK' TIPUS, LINK_ID::character varying(6) CODE, EXPL_ID FROM ws_migra.v_edit_link WHERE the_geom IS NULL
  UNION
  SELECT 'LEXPANSIONTANK' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_expansiontank WHERE the_geom IS NULL
  UNION
  SELECT 'FILTER' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_filter WHERE the_geom IS NULL
  UNION
  SELECT 'FLEXUNION' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_flexunion WHERE the_geom IS NULL
  UNION
  SELECT 'FOUNTAIN' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_fountain WHERE the_geom IS NULL
  UNION
  SELECT 'GREENTAP' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_greentap WHERE the_geom IS NULL
  UNION
  SELECT 'HYDRANT' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_hydrant WHERE the_geom IS NULL
  UNION
  SELECT 'JUNCTINO' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_junction WHERE the_geom IS NULL
  UNION
  SELECT 'MANHOLE' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_manhole WHERE the_geom IS NULL
  UNION
  SELECT 'METER' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_meter WHERE the_geom IS NULL
  UNION
  SELECT 'NETELEMENT' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_netelement WHERE the_geom IS NULL
  UNION
  SELECT 'NETSAMPLEPOINT' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_netsamplepoint WHERE the_geom IS NULL
  UNION
  SELECT 'NETWJOIN' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_netwjoin WHERE the_geom IS NULL
  UNION
  SELECT 'PIPE' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_pipe WHERE the_geom IS NULL
  UNION
  SELECT 'PUMP' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_pump WHERE the_geom IS NULL
  UNION
  SELECT 'REDUCTION' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_reduction WHERE the_geom IS NULL
  UNION
  SELECT 'REGISTER' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_register WHERE the_geom IS NULL
  UNION
  SELECT 'SOURCE' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_source WHERE the_geom IS NULL
  UNION
  SELECT 'TANK' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_tank WHERE the_geom IS NULL
  UNION
  SELECT 'TAP' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_tap WHERE the_geom IS NULL
  UNION
  SELECT 'VALVE' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_valve WHERE the_geom IS NULL
  UNION
  SELECT 'VARC' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_varc WHERE the_geom IS NULL
  UNION
  SELECT 'WATERWELL' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_waterwell WHERE the_geom IS NULL
  UNION
  SELECT 'WJOIN' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_wjoin WHERE the_geom IS NULL
  UNION
  SELECT 'WTP' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_man_wtp WHERE the_geom IS NULL
  UNION
  SELECT 'POND' TIPUS, pond_id::character varying(6) CODE, EXPL_ID FROM ws_migra.v_edit_pond WHERE the_geom IS NULL
  UNION
  SELECT 'POOL' TIPUS, pool_id::character varying(6) CODE, EXPL_ID FROM ws_migra.v_edit_pool WHERE the_geom IS NULL
  UNION
  SELECT 'SAMPLEPOINT' TIPUS, CODE, EXPL_ID FROM ws_migra.v_edit_samplepoint WHERE the_geom IS NULL
  ORDER BY TIPUS, CODE;



CREATE OR REPLACE VIEW ws_migra.amsa_ctrl_revi_dates AS
  SELECT 'greentap' obj_type, MIN(data_rev) min_value FROM ws_migra.amsa_rev_t_greentap
  UNION
  SELECT 'hydrant - dr', MIN(data_dr) FROM ws_migra.amsa_rev_t_hydrant
  UNION
  SELECT 'hydrant - fr', MIN(data_fr) FROM ws_migra.amsa_rev_t_hydrant
  UNION
  SELECT 'samplepoint', MIN(data_rev) FROM ws_migra.amsa_rev_t_samplepoint
  UNION
  SELECT 'tap', MIN(data_rev) FROM ws_migra_old.amsa_rev_t_tap
  UNION
  SELECT 'valve - dr', MIN(data_dr) FROM ws_migra.amsa_rev_t_valve
  UNION
  SELECT 'valve - fr', MIN(data_fr) FROM ws_migra.amsa_rev_t_valve
  UNION
  SELECT 'wjoin', MIN(data_rev) FROM ws_migra.amsa_rev_t_wjoin;





/* Taula de catàlegs nous =========================================================================


create table TMP_CAT_ELEMENT_PORTELLA 
(
  id varchar2(30),
  elementtype_id varchar2(30),
  matcat_id varchar2(30),
  geometry varchar2(30),
  descript varchar2(512),
  link varchar2(512),
  brand varchar2(30),
  type varchar2(30),
  model varchar2(30),
  svg varchar2(50),
  active varchar2(5)
)


*/








/* Taules de regions (geometries polygon) =========================================================

CREATE TABLE exploitation (
  expl_id integer NOT NULL,
  name varchar(50),
  macroexpl_id integer,
  descript varchar(50),
  undelete integer,
  the_geom SDO_GEOMETRY,
  tstamp DATE          DEFAULT SYSDATE NOT NULL,
  CONSTRAINT exploitation_pkey PRIMARY KEY (expl_id),
  CONSTRAINT exploitation_POLYGON_CK CHECK (the_geom.SDO_GTYPE IN (2003, 2007))
);

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('exploitation', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                           SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );
    CREATE INDEX exploitation_SIDX ON exploitation (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;


CREATE TABLE macroexploitation (
  macroexpl_id   integer NOT NULL,
  name           VARCHAR2(50),
  descript       VARCHAR2(100),
  undelete       INTEGER,
  CONSTRAINT macroexploitation_pkey PRIMARY KEY (macroexpl_id)
)


 CREATE TABLE DMA AS
 SELECT EXPL_ID*100 DMA_ID, NAME, EXPL_ID, EXPL_ID * 10 MACRODMA_ID, '-' DESCRIPT, 1 UNDELETE, 
        SDO_GEOMETRY(2003, 25831, NULL, C.THE_GEOM.SDO_ELEM_INFO, C.THE_GEOM.SDO_ORDINATES) THE_GEOM
 FROM   EXPLOITATION C;

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('dma', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                          SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );
    CREATE INDEX dma_SIDX ON dma (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;


CREATE TABLE MACRODMA AS
 SELECT EXPL_ID*10 MACRODMA_ID, NAME, EXPL_ID, '-' DESCRIPT, 1 UNDELETE, 
        SDO_GEOMETRY(2003, 25831, NULL, C.THE_GEOM.SDO_ELEM_INFO, C.THE_GEOM.SDO_ORDINATES) THE_GEOM
 FROM   EXPLOITATION C;

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('macrodma', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                           SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );
    CREATE INDEX macrodma_SIDX ON macrodma (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

    

CREATE TABLE SECTOR (
    SECTOR_ID      NUMBER(*,0) NOT NULL ENABLE,
    NAME           VARCHAR2(50 BYTE),
    MACROSECTOR_ID NUMBER(*,0),
    DESCRIPT       VARCHAR2(50 BYTE),
    UNDELETE       NUMBER(*,0),
    THE_GEOM       SDO_GEOMETRY,
    CONSTRAINT SECTOR_POLYGON_CK CHECK (the_geom.SDO_GTYPE IN (2003, 2007)) ENABLE,
    CONSTRAINT SECTOR_PKEY PRIMARY KEY (SECTOR_ID)
)

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('sector', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                           SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );
    // Eliminat index, perquè dóna error
    // CREATE INDEX sector_SIDX ON sector (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

    // Càrrega dels SECTORS

    INSERT INTO SECTOR 
    SELECT ID_SECTOR, NOM_SECTOR, NULL, '-' DESCRIPT, 1 UNDELETE,  SDO_GEOMETRY(2003, 25831, NULL, c.THE_GEOM.SDO_ELEM_INFO, c.THE_GEOM.SDO_ORDINATES)
    FROM   ZZ_SECTORS_CONSUM_MATARO C;

    INSERT INTO SECTOR 
    SELECT (ROWNUM + 20) * 10, ID_SUBXARX NOM_SECTOR, NULL, '-' DESCRIPT, 1 UNDELETE,  SDO_GEOMETRY(2003, 25831, NULL, c.THE_GEOM.SDO_ELEM_INFO, c.THE_GEOM.SDO_ORDINATES)
    FROM   ZZ_SECTORS_CONSUM_FIGARO C
    ORDER BY ID_SUBXARX;

    INSERT INTO SECTOR 
    SELECT (ROWNUM + 30) * 10, ID_SUBXARX NOM_SECTOR, NULL, '-' DESCRIPT, 1 UNDELETE,  SDO_GEOMETRY(2003, 25831, NULL, c.THE_GEOM.SDO_ELEM_INFO, c.THE_GEOM.SDO_ORDINATES)
    FROM   ZZ_SECTORS_CONSUM_LLISSA C
    ORDER BY ID_SUBXARX;

    // Edició manual del sector 320 per a que aparegui la illa dins d'un camp tipus Polygon


CREATE TABLE MACROSECTOR
(
  MACROSECTOR_ID NUMBER(*,0) NOT NULL ENABLE,
  NAME           VARCHAR2(50),
  DESCRIPT       VARCHAR2(50),
  UNDELETE       NUMBER(*,0),
  THE_GEOM       SDO_GEOMETRY,
  CONSTRAINT MACROSECTOR_PKEY PRIMARY KEY (MACROSECTOR_ID)
)


CREATE TABLE CAT_PRESSZONE (
    ID       VARCHAR2(30 BYTE) NOT NULL ENABLE,
    DESCRIPT VARCHAR2(50 BYTE),
    EXPL_ID  NUMBER(*,0),
    LINK     VARCHAR2(512 BYTE),
    CONSTRAINT CAT_PRESSZONE_PKEY PRIMARY KEY (ID)
);


================================================================================================ */


 /*
CREATE TABLE DMA (
    DMA_ID      NUMBER(*,0) NOT NULL ENABLE,
    NAME        VARCHAR2(50 BYTE),
    EXPL_ID     NUMBER(*,0),
    MACRODMA_ID NUMBER(*,0),
    DESCRIPT    VARCHAR2(50 BYTE),
    UNDELETE    NUMBER(*,0),
    THE_GEOM    SDO_GEOMETRY,
    CONSTRAINT DMA_POLYGON_CK CHECK (the_geom.SDO_GTYPE IN (2003, 2007)) ENABLE,
    CONSTRAINT DMA_PKEY" PRIMARY KEY (DMA_ID)
)



    UPDATE DMA set the_geom = (SELECT the_geom from exploitation where expl_id = 1) where dma_id = 1
    UPDATE DMA set the_geom = (SELECT the_geom from exploitation where expl_id = 2) where dma_id = 2
    UPDATE DMA set the_geom = (SELECT the_geom from exploitation where expl_id = 3) where dma_id = 3
    UPDATE DMA set the_geom = (SELECT the_geom from exploitation where expl_id = 4) where dma_id = 4


CREATE TABLE MACRODMA (
    MACRODMA_ID NUMBER(*,0) NOT NULL ENABLE,
    NAME        VARCHAR2(50 BYTE),
    EXPL_ID     NUMBER(*,0),
    DESCRIPT    VARCHAR2(50 BYTE),
    UNDELETE    NUMBER(*,0),
    THE_GEOM    SDO_GEOMETRY,
    CONSTRAINT MACRODMA_POLYGON_CK CHECK (the_geom.SDO_GTYPE IN (2003, 2007)) ENABLE,
    CONSTRAINT MACRODMA_PKEY PRIMARY KEY (MACRODMA_ID)
)

INSERT INTO macrodma SELECT dma_id, name, expl_id, descript, undelete, the_geom FROM dma;
*/





/* CÀRREGA PROVISIONAL DE DADES


CREATE TABLE ZZ_SECTORS_CONSUM (
    THE_GEOM   SDO_GEOMETRY,
    ID_SECTOR  NUMBER(*,0),
    NOM_SECTOR VARCHAR2(2000 BYTE)
)

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('ZZ_SECTORS_CONSUM', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                           SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );

    ** Càrrega amb GeoKettle

    ** Assignació manual del SRID (25831)

    UPDATE ZZ_SECTORS_CONSUM c SET THE_GEOM = SDO_GEOMETRY(2007, 25831, NULL, c.THE_GEOM.SDO_ELEM_INFO, c.THE_GEOM.SDO_ORDINATES);

    CREATE INDEX ZZ_SECTORS_CONSUM_SIDX ON ZZ_SECTORS_CONSUM (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

    ** Bolcat a DMA

    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 10) WHERE  DMA_ID = 10;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 11) WHERE  DMA_ID = 11;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 20) WHERE  DMA_ID = 20;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 21) WHERE  DMA_ID = 21;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 22) WHERE  DMA_ID = 22;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 30) WHERE  DMA_ID = 30;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 31) WHERE  DMA_ID = 31;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 40) WHERE  DMA_ID = 40;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 50) WHERE  DMA_ID = 50;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 60) WHERE  DMA_ID = 60;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 61) WHERE  DMA_ID = 61;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 62) WHERE  DMA_ID = 62;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 63) WHERE  DMA_ID = 63;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 64) WHERE  DMA_ID = 64;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 70) WHERE  DMA_ID = 70;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 71) WHERE  DMA_ID = 71;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 100) WHERE  DMA_ID = 100;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 95) WHERE  DMA_ID = 95;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS_CONSUM WHERE ID_SECTOR = 164) WHERE  DMA_ID = 164;

    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM EXPLOITATION WHERE EXPL_ID = 2) WHERE  DMA_ID = 200;
    UPDATE DMA SET    THE_GEOM = (SELECT THE_GEOM FROM EXPLOITATION WHERE EXPL_ID = 3) WHERE  DMA_ID = 300;


CREATE TABLE ZZ_SECTORS AS
SELECT 
NOM_SECTOR, SDO_AGGR_UNION(SDOAGGRTYPE(the_geom, 0.005)) THE_GEOM
FROM ( 
             SELECT NOM_SECTOR, /*+ NO_MERGE * / the_geom 
             FROM ZZ_SECTORS_CONSUM 
)
GROUP BY NOM_SECTOR; 

    INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, SRID, DIMINFO)
    VALUES ('ZZ_SECTORS', 'the_geom', 25831, 
            SDO_DIM_ARRAY (SDO_DIM_ELEMENT('X',  450000.0,  458000.0, 0.0001), 
                           SDO_DIM_ELEMENT('Y', 4596000.0, 4605000.0, 0.0001) ) );

    CREATE INDEX ZZ_SECTORS_SIDX ON ZZ_SECTORS (the_geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

    ** Bolcat a SECTOR

    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 1) WHERE SECTOR_ID = 1;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 2) WHERE SECTOR_ID = 2;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 3) WHERE SECTOR_ID = 3;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 4) WHERE SECTOR_ID = 4;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 5) WHERE SECTOR_ID = 5;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 6) WHERE SECTOR_ID = 6;
    UPDATE SECTOR SET    THE_GEOM = (SELECT THE_GEOM FROM ZZ_SECTORS WHERE NOM_SECTOR = 7) WHERE SECTOR_ID = 7;

    // PROVISIONAL    UPDATE SECTOR set the_geom = (SELECT the_geom from exploitation where expl_id = 2) where SECTOR_ID = 20
    // PROVISIONAL    UPDATE SECTOR set the_geom = (SELECT the_geom from exploitation where expl_id = 3) where SECTOR_ID = 30
*/



/*
-- VISTES EDITABLES (V_EDIT_MAN_*) + SAMPLEPOINT / POND / POOL / DIMENSIONS / ELEMENT / LINK / NODE 
CREATE TABLE ws_migra.v_edit_dimensions AS SELECT * FROM ws.v_edit_dimensions WHERE 1=2;
CREATE TABLE ws_migra.v_edit_element AS SELECT * FROM ws.v_edit_element WHERE 1=2;
CREATE TABLE ws_migra.v_edit_link AS SELECT * FROM ws.v_edit_link WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_expansiontank AS SELECT * FROM ws.v_edit_man_expansiontank WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_filter AS SELECT * FROM ws.v_edit_man_filter WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_flexunion AS SELECT * FROM ws.v_edit_man_flexunion WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_fountain AS SELECT * FROM ws.v_edit_man_fountain WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_fountain_pol AS SELECT * FROM ws.v_edit_man_fountain_pol WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_greentap AS SELECT * FROM ws.v_edit_man_greentap WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_hydrant AS SELECT * FROM ws.v_edit_man_hydrant WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_junction AS SELECT * FROM ws.v_edit_man_junction WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_manhole AS SELECT * FROM ws.v_edit_man_manhole WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_meter AS SELECT * FROM ws.v_edit_man_meter WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_netelement AS SELECT * FROM ws.v_edit_man_netelement WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_netsamplepoint AS SELECT * FROM ws.v_edit_man_netsamplepoint WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_netwjoin AS SELECT * FROM ws.v_edit_man_netwjoin WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_pipe AS SELECT * FROM ws.v_edit_man_pipe WHERE 1=2;


CREATE TABLE ws_migra.v_edit_man_pump AS SELECT * FROM ws.v_edit_man_pump WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_reduction AS SELECT * FROM ws.v_edit_man_reduction WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_register AS SELECT * FROM ws.v_edit_man_register WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_register_pol AS SELECT * FROM ws.v_edit_man_register_pol WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_source AS SELECT * FROM ws.v_edit_man_source WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_tank AS SELECT * FROM ws.v_edit_man_tank WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_tank_pol AS SELECT * FROM ws.v_edit_man_tank_pol WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_tap AS SELECT * FROM ws.v_edit_man_tap WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_valve AS SELECT * FROM ws.v_edit_man_valve WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_varc AS SELECT * FROM ws.v_edit_man_varc WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_waterwell AS SELECT * FROM ws.v_edit_man_waterwell WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_wjoin AS SELECT * FROM ws.v_edit_man_wjoin WHERE 1=2;
CREATE TABLE ws_migra.v_edit_man_wtp AS SELECT * FROM ws.v_edit_man_wtp WHERE 1=2;
CREATE TABLE ws_migra.v_edit_pond AS SELECT * FROM ws.v_edit_pond WHERE 1=2;
CREATE TABLE ws_migra.v_edit_pool AS SELECT * FROM ws.v_edit_pool WHERE 1=2;
CREATE TABLE ws_migra.v_edit_samplepoint AS SELECT * FROM ws.v_edit_samplepoint WHERE 1=2;
CREATE TABLE ws_migra.v_edit_vnode AS SELECT * FROM ws.v_edit_vnode WHERE 1=2;
*/
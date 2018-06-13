
CREATE OR REPLACE VIEW cat_mat_node AS

  -- MATERIALS PER CAT_CONNEC

  SELECT SET_CONNEC_MAT( ID_PMAT )    AS "id",
         INITCAP( ID_PMAT )           AS descript,
         null                         AS "link"
  FROM   NS_MATARO.CAT_POU_MATERIAL
  
  UNION
  
  SELECT SET_CONNEC_MAT( ID_CONMAT )  AS "id",
         INITCAP( ID_CONMAT )         AS descript,
         null                         AS "link"
  FROM   NS_MATARO.CAT_CONNEXIO_MATERIAL
  
  UNION
  
  -- MATERIALS PER CAT_GRATE
  
  SELECT SET_GRATE_MAT( ID_RMAT )     AS "id",
         INITCAP( ID_RMAT )           AS descript,
         null                         AS "link"
  FROM   NS_MATARO.CAT_REIXA_MATERIAL;
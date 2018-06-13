
CREATE OR REPLACE VIEW cat_mat_gully AS

  SELECT ID_CAIXO                     AS "id",
         INITCAP( CAIXO )             AS descript,
         null                         AS "link"
  FROM   NS_MATARO.CAT_EMBORNAL_CAIXO;
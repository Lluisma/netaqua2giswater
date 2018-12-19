

CREATE OR REPLACE FORCE VIEW CAT_WORK AS

  SELECT  DISTINCT
          T1.EXPEDIENT AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_NODE T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPBAIXA AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_NODE T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPEDIENT AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_TRAM T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPBAIXA AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_TRAM T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPEDIENT AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_CLAVEGUERO T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPBAIXA AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_CLAVEGUERO T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPEDIENT AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_EMBORNAL T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPBAIXA AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_EMBORNAL T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPEDIENT AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_REIXA T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          T1.EXPBAIXA AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CAST(null AS INTEGER) AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_REIXA T1
  WHERE   (T1.EXPBAIXA <> '0')
  ORDER BY workid_key1;


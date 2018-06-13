

CREATE OR REPLACE FORCE VIEW CAT_WORK AS

  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT
            WHEN T1.OT_PART = 0 THEN T1.EXPEDIENT
            ELSE T1.EXPEDIENT || '-' || T1.OT_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CASE
            WHEN T1.OT_PART = 0 THEN NULL
            ELSE T1.OT_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_NODE T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
            WHEN T1.OT_BAIXA_PART = 0 THEN T1.EXPBAIXA
            ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CASE 
            WHEN T1.OT_BAIXA_PART = 0 THEN NULL
            ELSE T1.OT_BAIXA_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_NODE T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT
            WHEN T1.OT_PART = 0 THEN T1.EXPEDIENT
            ELSE T1.EXPEDIENT || '-' || T1.OT_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CASE
            WHEN T1.OT_PART = 0 THEN NULL
            ELSE T1.OT_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_TRAM T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
            WHEN T1.OT_BAIXA_PART = 0 THEN T1.EXPBAIXA
            ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CASE 
            WHEN T1.OT_BAIXA_PART = 0 THEN NULL
            ELSE T1.OT_BAIXA_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_TRAM T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT
            WHEN T1.OT_PART = 0 THEN T1.EXPEDIENT
            ELSE T1.EXPEDIENT || '-' || T1.OT_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CASE
            WHEN T1.OT_PART = 0 THEN NULL
            ELSE T1.OT_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_CLAVEGUERO T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
            WHEN T1.OT_BAIXA_PART = 0 THEN T1.EXPBAIXA
            ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CASE 
            WHEN T1.OT_BAIXA_PART = 0 THEN NULL
            ELSE T1.OT_BAIXA_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_CLAVEGUERO T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT
            WHEN T1.OT_PART = 0 THEN T1.EXPEDIENT
            ELSE T1.EXPEDIENT || '-' || T1.OT_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CASE
            WHEN T1.OT_PART = 0 THEN NULL
            ELSE T1.OT_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_EMBORNAL T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
            WHEN T1.OT_BAIXA_PART = 0 THEN T1.EXPBAIXA
            ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CASE 
            WHEN T1.OT_BAIXA_PART = 0 THEN NULL
            ELSE T1.OT_BAIXA_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_EMBORNAL T1
  WHERE   (T1.EXPBAIXA <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_PART IS NULL THEN T1.EXPEDIENT
            WHEN T1.OT_PART = 0 THEN T1.EXPEDIENT
            ELSE T1.EXPEDIENT || '-' || T1.OT_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPEDIENT AS workid_key1,
          CASE
            WHEN T1.OT_PART = 0 THEN NULL
            ELSE T1.OT_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_REIXA T1
  WHERE   (T1.EXPEDIENT <> '0')
  UNION
  SELECT  DISTINCT
          CASE 
            WHEN T1.OT_BAIXA_PART IS NULL THEN T1.EXPBAIXA
            WHEN T1.OT_BAIXA_PART = 0 THEN T1.EXPBAIXA
            ELSE T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          END AS id,
          NULL AS descript,
          NULL AS link,
          T1.EXPBAIXA AS workid_key1,
          CASE 
            WHEN T1.OT_BAIXA_PART = 0 THEN NULL
            ELSE T1.OT_BAIXA_PART
          END AS workid_key2,
          NULL AS builtdate,
          NULL AS the_geom
  FROM    NS_MATARO.CL_V_REIXA T1
  WHERE   (T1.EXPBAIXA <> '0')
  ORDER BY workid_key1;


/*
  REVISIONS
  =================================================================================================

  CREATE OR REPLACE VIEW REVI_CAT_WORK AS
  SELECT *
  FROM   GW_CAT_WORK
  WHERE  workid_key1 LIKE '%-%'
     OR  (SUBSTR(workid_key1, 0, 1)<>'C' AND SUBSTR(workid_key1, 0, 2)<>'CE'
          AND SUBSTR(workid_key1, 0, 2)<>'XE' AND SUBSTR(workid_key1, 0, 2)<>'WE')
  UNION
  SELECT *
  FROM   CAT_WORK
  WHERE  (SUBSTR(workid_key1, 0, 2) IN ('AE','CE','XE'))
    AND  workid_key2 IS NOT NULL
  UNION
  SELECT *
  FROM   CAT_WORK
  WHERE  workid_key1 IS NULL
    AND  workid_key2 IS NOT NULL;

*/

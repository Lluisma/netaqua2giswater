
-- ABASTAMENT

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.EXT_TYPE_STREET AS

  SELECT DISTINCT T1.TIPUS_VIA       ID,
         CASE T1.TIPUS_VIA
           WHEN 'AV' THEN 'Avinguda'
           WHEN 'C'  THEN 'Carrer'
           WHEN 'PL' THEN 'Plaça'
           WHEN 'PS' THEN 'Passeig'
           WHEN 'PT' THEN 'Passatge'
           WHEN 'RD' THEN 'Ronda'
           ELSE T1.TIPUS_VIA END     OBSERV
  FROM   NA_MATARO.CAT_T_CARRER T1
  WHERE  T1.TIPUS_VIA IS NOT NULL
  UNION
  SELECT DISTINCT T1.TIPUS_VIA       ID,
         CASE T1.TIPUS_VIA
           WHEN 'AV' THEN 'Avinguda'
           WHEN 'C'  THEN 'Carrer'
           WHEN 'PL' THEN 'Plaça'
           WHEN 'PS' THEN 'Passeig'
           WHEN 'PT' THEN 'Passatge'
           WHEN 'RD' THEN 'Ronda'
           ELSE T1.TIPUS_VIA END     OBSERV
  FROM   NA_FIGARO.CAT_T_CARRER T1
  WHERE  T1.TIPUS_VIA IS NOT NULL
  UNION
  SELECT DISTINCT T1.TIPUS_VIA       ID,
         CASE T1.TIPUS_VIA
           WHEN 'AV' THEN 'Avinguda'
           WHEN 'C'  THEN 'Carrer'
           WHEN 'PL' THEN 'Plaça'
           WHEN 'PS' THEN 'Passeig'
           WHEN 'PT' THEN 'Passatge'
           WHEN 'RD' THEN 'Ronda'
           ELSE T1.TIPUS_VIA END     OBSERV
  FROM   NA_LLISSADEVALL.CAT_T_CARRER T1
  WHERE  T1.TIPUS_VIA IS NOT NULL
  ORDER BY ID, OBSERV;


-- CLAVEGUERAM

CREATE OR REPLACE VIEW GW_MIGRA_NETSANEA.EXT_TYPE_STREET AS

  SELECT DISTINCT T1.TIPUS_VIA       ID,
         CASE T1.TIPUS_VIA
           WHEN 'AV' THEN 'Avinguda'
           WHEN 'C'  THEN 'Carrer'
           WHEN 'PL' THEN 'Plaça'
           WHEN 'PS' THEN 'Passeig'
           WHEN 'PT' THEN 'Passatge'
           WHEN 'RD' THEN 'Ronda'
           ELSE T1.TIPUS_VIA END     OBSERV
  --FROM   NS_MATARO.CAT_T_CARRER T1
  FROM   NA_MATARO.CAT_T_CARRER T1
  WHERE  T1.TIPUS_VIA IS NOT NULL
  ORDER BY ID, OBSERV;
  
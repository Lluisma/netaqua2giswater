
CREATE OR REPLACE VIEW CAT_BRAND_MODEL AS 
  SELECT DISTINCT 
         CASE 
           WHEN (REI_TIP IS NULL OR REI_TIP='-') AND (SET_GRATE_BRAND(REI_FAB)='XX_') THEN 'XX'
           WHEN (REI_TIP IS NULL OR REI_TIP='-') THEN SET_GRATE_BRAND(REI_FAB) || 'XX'
           ELSE SET_GRATE_BRAND( REI_FAB ) || REI_TIP
         END                           AS "id",
         CASE
           WHEN REI_FAB='-' THEN 'XX'
           WHEN REI_FAB IS NULL THEN 'XX'
           ELSE REPLACE(REI_FAB,'Á','A')
         END                           AS catbrand_id,
         CASE
           WHEN (REI_FAB IS NULL OR REI_FAB='-') AND (REI_TIP IS NULL OR REI_TIP='-') THEN 'Reixa desconeguda'
           WHEN (REI_TIP IS NULL OR REI_TIP='-') THEN INITCAP(REI_FAB) || ' - Model desconegut'
           WHEN (REI_FAB IS NULL OR REI_FAB='-') THEN 'Marca desconeguda - ' || INITCAP(REI_TIP) 
           ELSE                                       INITCAP(REI_FAB) || ' - ' || INITCAP(REI_TIP) 
         END                           AS descript,
         null                          AS "link"
  FROM NS_MATARO.CL_V_EMBORNAL
  
  UNION
  
  SELECT DISTINCT 
         CASE 
           WHEN (REI_TIP IS NULL OR REI_TIP='-') AND (SET_GRATE_BRAND(REI_FAB)='XX_') THEN 'XX'
           WHEN (REI_TIP IS NULL OR REI_TIP='-') THEN SET_GRATE_BRAND(REI_FAB) || 'XX'
           ELSE SET_GRATE_BRAND( REI_FAB ) || REI_TIP
         END                           AS "id",
         CASE
           WHEN REI_FAB='-' THEN 'XX'
           WHEN REI_FAB IS NULL THEN 'XX'
           ELSE REPLACE(REI_FAB,'Á','A')
         END                           AS catbrand_id,
         CASE
           WHEN (REI_FAB IS NULL OR REI_FAB='-') AND (REI_TIP IS NULL OR REI_TIP='-') THEN 'Reixa desconeguda'
           WHEN (REI_TIP IS NULL OR REI_TIP='-') THEN INITCAP(REI_FAB) || ' - Model desconegut'
           WHEN (REI_FAB IS NULL OR REI_FAB='-') THEN 'Marca desconeguda - ' || INITCAP(REI_TIP) 
           ELSE                                       INITCAP(REI_FAB) || ' - ' || INITCAP(REI_TIP) 
         END                           AS descript,
         null                          AS "link"
  FROM NS_MATARO.CL_V_REIXA
  
  ORDER BY 1;

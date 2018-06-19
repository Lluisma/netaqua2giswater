
CREATE OR REPLACE VIEW TMP_CAT_GRATE AS 
  SELECT DISTINCT
         SET_GRATE_BRAND( REI_FAB )
         ||
         CASE 
           WHEN REI_TIP='DELTA'            THEN 'DELT_'
           WHEN REI_TIP='DELTA ARTICULADA' THEN 'DART_'
           WHEN REI_TIP='IMPU'             THEN 'IMPU_'
           WHEN REI_TIP='MARESME'          THEN 'MARE_'
           WHEN REI_TIP='ONDA'             THEN 'ONDA_'
           WHEN REI_TIP='QUADRADA'         THEN 'QUAD_'
           WHEN (REI_TIP = '-' OR REI_TIP IS NULL) AND (SET_GRATE_MAT(REI_MAT)<>'XX') THEN SET_GRATE_MAT(REI_MAT) || '_'
           WHEN (REI_TIP = '-' OR REI_TIP IS NULL) THEN ''
           ELSE '00ERROR00'
        END
        ||
        CASE
          WHEN (REI_AMP=0 AND REI_ALT=0) THEN 'XX'
          ELSE
        CASE
          WHEN REI_AMP<1000 THEN LPAD(REI_AMP,3,'0')
          ELSE TO_CHAR(REI_AMP)
        END
        || 'x' ||
        CASE
          WHEN REI_ALT<1000 THEN LPAD(REI_ALT,3,'0')
          ELSE TO_CHAR(REI_ALT)
          END
        END                                 AS "id",
        SET_GRATE_MAT(REI_MAT)              AS matcat_id,
        CASE REI_FAB
          WHEN '-' THEN null
          ELSE REPLACE(INITCAP(REI_FAB),'à','a')
        END                                 AS desc_brand,
        CASE REI_TIP
          WHEN '-' THEN null
          ELSE INITCAP(REI_TIP)
        END                                 AS desc_model,
        CASE REI_FAB
          WHEN '-' THEN null
          ELSE REI_FAB
        END                                 AS rei_fab, 
        CASE REI_TIP
          WHEN '-' THEN null
          ELSE REI_TIP
        END                                 AS rei_tip, 
        CASE REI_MAT
          WHEN '-' THEN null
          ELSE REI_MAT
        END                                 AS rei_mat, 
        REI_FAB || '_' || REI_TIP || '_' || REI_MAT || '_' || REI_ALT  || '_' || REI_AMP AS id_clau,
        REI_AMP, REI_ALT
  FROM NS_MATARO.CL_V_EMBORNAL
  
  UNION
  
  SELECT DISTINCT
         SET_GRATE_BRAND( REI_FAB )                             
         ||
         CASE 
           WHEN REI_TIP='DELTA'            THEN 'DELT_'
           WHEN REI_TIP='DELTA ARTICULADA' THEN 'DART_'
           WHEN REI_TIP='IMPU'             THEN 'IMPU_'
           WHEN REI_TIP='MARESME'          THEN 'MARE_'
           WHEN REI_TIP='ONDA'             THEN 'ONDA_'
           WHEN REI_TIP='QUADRADA'         THEN 'QUAD_'
           WHEN (REI_TIP = '-' OR REI_TIP IS NULL) AND (SET_GRATE_MAT(REI_MAT)<>'XX') THEN SET_GRATE_MAT(REI_MAT) || '_'
           WHEN (REI_TIP = '-' OR REI_TIP IS NULL) THEN ''
           ELSE '00ERROR00'
        END
        ||
        CASE
          WHEN LLARGADA=0 AND AMPLE<1000 THEN LPAD(AMPLE,3,'0')
          WHEN LLARGADA=0 THEN TO_CHAR(AMPLE)
          WHEN LLARGADA<1000 THEN LPAD(LLARGADA,3,'0')
          ELSE TO_CHAR(LLARGADA)
        END
        || 'x' ||
        CASE
          WHEN ALT<1000 THEN LPAD(ALT,3,'0')
          ELSE TO_CHAR(ALT)
        END                                 AS "id",
        SET_GRATE_MAT(REI_MAT)              AS matcat_id,
        CASE REI_FAB
          WHEN '-' THEN null
          ELSE REPLACE(REPLACE(INITCAP(REI_FAB),'à','a'),'á','a')
        END                                 AS desc_brand,
        CASE REI_TIP
          WHEN '-' THEN null
          ELSE INITCAP(REI_TIP)
        END                                 AS desc_model,
        CASE REI_FAB
          WHEN '-' THEN null
          ELSE REI_FAB
        END                                 AS rei_fab, 
        CASE REI_TIP
          WHEN '-' THEN null
          ELSE REI_TIP
        END                                 AS rei_tip, 
        CASE REI_MAT
          WHEN '-' THEN null
          ELSE REI_MAT
        END                                 AS rei_mat, 

        REI_FAB || '_' || REI_TIP || '_' || REI_MAT || '_' || ALT  || '_' || CASE WHEN LLARGADA=0 THEN AMPLE ELSE LLARGADA END AS id_clau,
        CASE 
          WHEN LLARGADA=0 THEN AMPLE
          ELSE LLARGADA
        END                                 AS LLARGADA,
        ALT
  FROM NS_MATARO.CL_V_REIXA;



CREATE OR REPLACE VIEW CAT_GRATE AS 
  SELECT DISTINCT
         "id",
         matcat_id,
         REI_ALT/100                   AS "length",
         REI_AMP/100                   AS width,
         (REI_ALT/100)*(REI_AMP/100)   AS total_area,
         CAST(null AS NUMERIC)         AS efective_area,
         CAST(null AS NUMERIC)         AS n_barr_l,
         CAST(null AS NUMERIC)         AS n_barr_w,
         CAST(null AS NUMERIC)         AS n_barr_diag,
         CAST(null AS NUMERIC)         AS a_param,
         CAST(null AS NUMERIC)         AS b_param,
         CASE 
           WHEN desc_brand IS NULL AND desc_model IS NULL THEN 'Reixa desconeguda : '
           WHEN desc_brand IS NULL THEN 'Tipus ' || desc_model || ' : '
           WHEN desc_model IS NULL THEN desc_brand || ' : '
           ELSE desc_brand || ' - ' || desc_model || ' : '
         END
         || REI_AMP || 'x' || REI_ALT  AS descript,
         null                          AS "link",
         REPLACE(REI_FAB,'Á','A')      AS brand,
         CASE 
           WHEN (REI_TIP IS NULL OR REI_TIP='-') AND (SET_GRATE_BRAND(REI_FAB)='XX_') THEN 'XX'
           WHEN (REI_TIP IS NULL OR REI_TIP='-') THEN SET_GRATE_BRAND(REI_FAB) || 'XX'
           ELSE SET_GRATE_BRAND( REI_FAB ) || REI_TIP
         END                           AS "model",
         null                          AS svg,
         null                          AS cost_ut,
         'true'                        AS active
  FROM TMP_CAT_GRATE
  ORDER BY 1;

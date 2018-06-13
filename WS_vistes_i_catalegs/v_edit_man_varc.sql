
-- NO S'APLIQUEN LES REGLES TOPOLÒGIQUES SOBRE ELS ELEMENTS DE BAIXA (igual que a NETAQUA)

-- NOMÉS PER NA_MATARO (XARXA TERCIÀRIA NO UTILITZADA A NA_FIGARO / NA_LLISSADEVALL)

CREATE OR REPLACE VIEW V_EDIT_MAN_VARC AS

SELECT  T1.ID_TRAM                              arc_id,
        T1.ID_TRAM                              code,
        CASE 
          -- WHEN T1.TIPUS_NODE1 IS NOT NULL AND T1.ID_NODE1 IS NOT NULL THEN T1.TIPUS_NODE1 || '_' || T1.ID_NODE1
          -- ELSE null
          WHEN T1.TIPUS_NODE1 IS NULL OR T1.ID_NODE1 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE1
          ELSE 'zERR ' || T1.TIPUS_NODE1 || '_' || T6.NODE_TIPUS || '_' || T1.ID_NODE1
        END                                     node_1,
        CASE 
          -- WHEN T1.TIPUS_NODE2 IS NOT NULL AND T1.ID_NODE2 IS NOT NULL THEN T1.TIPUS_NODE2 || '_' || T1.ID_NODE2
          -- ELSE null
          WHEN T1.TIPUS_NODE2 IS NULL OR T1.ID_NODE2 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE2
          ELSE 'zERR ' || T1.TIPUS_NODE2 || '_' || T7.NODE_TIPUS || '_' || T1.ID_NODE2
        END                                     node_2,
        T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                                    arccat_id,
        'VARC'                                  cat_arctype_id,       
        '-'                                     matcat_id,
        '-'                                     cat_pnom,
        '-'                                     cat_dnom,
        null                                    epa_type,
        CASE
          WHEN T1.ZONA = 0 THEN NULL
          ELSE T1.ZONA
        END                                     sector_id,
        T9.MACROSECTOR_ID                       macrosector_id,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                     state,
        CASE
          WHEN T1.ESTAT = 'B' THEN 0
          WHEN T1.ID_SUBXARXA='TRAM_FS' THEN 10
          WHEN T1.ID_SUBXARXA='PISPROV' THEN 12
          WHEN T1.ID_SUBXARXA='PISOBRES' THEN 13
          ELSE 11
        END                                     state_type,
        null                                    annotation,
        null                                    observ,
        null                                    "comment",
        CAST(null AS NUMBER)                    gis_length,
        T1.LONGITUD                             custom_length,
        1                                       dma_id,
        CASE
          WHEN T1.ID_SUBXARXA = 'TRAM_FS' THEN T9.DESCRIPT
          WHEN T1.ID_SUBXARXA = 'PISPROV' THEN T9.DESCRIPT
          WHEN T1.ID_SUBXARXA = 'PISOBRES' THEN T9.DESCRIPT
          WHEN T5.GRUP = 'PIS65'   THEN 'M_65'
          WHEN T5.GRUP = 'PIS100'  THEN 'M_100'
          WHEN T5.GRUP = 'PIS140'  THEN 'M_140'
          WHEN T5.GRUP = 'PIS185'  THEN 'M_185'
          WHEN T5.GRUP = 'PIS240'  THEN 'M_240'
          WHEN T5.GRUP = 'PIS310'  THEN 'M_310'
          WHEN T5.GRUP = 'PIS420'  THEN 'M_420'
          WHEN T5.GRUP = 'PISCOND' THEN 'M_COND'
          WHEN T5.GRUP = 'PISREG'  THEN 'M_REG'
          ELSE 'ERR_PRESSZONE'
        END                                     presszonecat_id,
        null                                    soilcat_id,
        null                                    function_type,
        CASE T5.CATEGORIA
          WHEN 'P' THEN 'P'
          WHEN 'S' THEN 'S'
          ELSE null
        END                                     category_type,
        null                                    fluid_type,
        null                                    location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
          ELSE T1.EXPEDIENT
        END                                     workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          ELSE T1.EXPBAIXA
        END                                     workcat_id_end,
        null                                    buildercat_id,
        T1.DATA_INST                            builtdate,
        T1.DATA_BAIXA                           enddate,
        null                                    ownercat_id,
        1                                       muni_id,
        CAST(null AS INTEGER)                   postcode,
        null                                    streetaxis_id,
        CAST(null AS INTEGER)                   postnumber,
        null                                    postcomplement,
        null                                    streetaxis2_id,
        CAST(null AS INTEGER)                   postnumber2,
        null                                    postcomplement2,
        null                                    descript,
        '-'                                     link,
        null                                    verified,
        T2.XY_GEO                               the_geom,
        null                                    undelete,        
        null                                    label_x,
        null                                    label_y,
        CAST(null AS NUMBER)                    label_rotation,
        'true'                                  publish,
        'true'                                  inventory,
        T1.ZONA                                 macrodma_id,
        1                                       expl_id,
        CAST(null AS NUMBER)                    num_value
FROM    NA_MATARO.NA_V_TRAM T1
          LEFT JOIN NA_MATARO.NA3_T_TRAM T2 ON T1.ID_TRAM = T2.ID_TRAM
          LEFT JOIN NA_MATARO.CAT_T_MATERIAL T4 ON T1.ID_MATERIAL = T4.ID_MATERIAL
          LEFT JOIN NA_MATARO.CAT_T_SUBXARXA T5 ON T1.ID_SUBXARXA = T5.ID_SUBXARXA
          LEFT JOIN NA_MATARO.NA_V_NODE T6 ON T1.ID_NODE1 = T6.ID_NODE AND T1.TIPUS_NODE1 = 'NODE'
          LEFT JOIN NA_MATARO.NA_V_NODE T7 ON T1.ID_NODE2 = T7.ID_NODE AND T1.TIPUS_NODE2 = 'NODE'
          LEFT JOIN NA_MATARO.CAT2_T_ZONA_CONSUM T8 ON T1.ZONA = T8.ZONA_ID
          LEFT JOIN SECTOR T9 ON T1.ZONA = T9.SECTOR_ID
WHERE   T5.CATEGORIA = 'T'

UNION ALL

SELECT  T1.ID_TRAM                              arc_id,
        T1.ID_TRAM                              code,
        CASE 
          -- WHEN T1.TIPUS_NODE1 IS NOT NULL AND T1.ID_NODE1 IS NOT NULL THEN T1.TIPUS_NODE1 || '_' || T1.ID_NODE1
          -- ELSE null
          WHEN T1.TIPUS_NODE1 IS NULL OR T1.ID_NODE1 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE1
          ELSE 'zERR ' || T1.TIPUS_NODE1 || '_' || T6.NODE_TIPUS || '_' || T1.ID_NODE1
        END                                     node_1,
        CASE 
          -- WHEN T1.TIPUS_NODE2 IS NOT NULL AND T1.ID_NODE2 IS NOT NULL THEN T1.TIPUS_NODE2 || '_' || T1.ID_NODE2
          -- ELSE null
          WHEN T1.TIPUS_NODE2 IS NULL OR T1.ID_NODE2 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE2
          ELSE 'zERR ' || T1.TIPUS_NODE2 || '_' || T7.NODE_TIPUS || '_' || T1.ID_NODE2
        END                                     node_2,
        T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                                    arccat_id,
        'VARC'                                  cat_arctype_id,       
        '-'                                     matcat_id,
        '-'                                     cat_pnom,
        '-'                                     cat_dnom,
        null                                    epa_type,
        T8.SECTOR_ID                            sector_id,
        T8.MACROSECTOR_ID                       macrosector_id,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                     state,
        CASE
          WHEN T1.ESTAT = 'B' THEN 0
          ELSE 11
        END                                     state_type,
        null                                    annotation,
        null                                    observ,
        null                                    "comment",
        CAST(null AS NUMBER)                    gis_length,
        T1.LONGITUD                             custom_length,
        200                                     dma_id,
        T9.ID                                   presszonecat_id,
        null                                    soilcat_id,
        null                                    function_type,
        null                                    category_type,
        null                                    fluid_type,
        null                                    location_type,
        T1.EXPEDIENT                            workcat_id,
        T1.EXPBAIXA                             workcat_id_end,
        null                                    buildercat_id,
        T1.DATA_INST                            builtdate,
        T1.DATA_BAIXA                           enddate,
        null                                    ownercat_id,
        2                                       muni_id,
        CAST(null AS INTEGER)                   postcode,
        null                                    streetaxis_id,
        CAST(null AS INTEGER)                   postnumber,
        null                                    postcomplement,
        null                                    streetaxis2_id,
        CAST(null AS INTEGER)                   postnumber2,
        null                                    postcomplement2,
        null                                    descript,
        '-'                                     link,
        null                                    verified,
        T2.THE_GEOM                             the_geom,
        null                                    undelete,        
        null                                    label_x,
        null                                    label_y,
        CAST(null AS NUMBER)                    label_rotation,
        'true'                                  publish,
        'true'                                  inventory,
        T1.ZONA                                 macrodma_id,
        2                                       expl_id,
        CAST(null AS NUMBER)                    num_value
FROM    NA_FIGARO.NA_V_TRAM T1
          LEFT JOIN FIGARO_NA3_T_TRAM T2 ON T1.ID_TRAM = T2.ID_TRAM
          LEFT JOIN NA_FIGARO.CAT_T_MATERIAL T4 ON T1.ID_MATERIAL = T4.ID_MATERIAL
          LEFT JOIN NA_FIGARO.CAT_T_SUBXARXA T5 ON T1.ID_SUBXARXA = T5.ID_SUBXARXA
          LEFT JOIN NA_FIGARO.NA_V_NODE T6 ON T1.ID_NODE1 = T6.ID_NODE AND T1.TIPUS_NODE1 = 'NODE'
          LEFT JOIN NA_FIGARO.NA_V_NODE T7 ON T1.ID_NODE2 = T7.ID_NODE AND T1.TIPUS_NODE2 = 'NODE'
          LEFT JOIN CAT_PRESSZONE T9 ON T1.ID_SUBXARXA = T9.LINK
          LEFT JOIN SECTOR T8 ON T9.ID = T8.DESCRIPT
WHERE   T1.ID_SUBXARXA LIKE '%T'

UNION ALL

SELECT  T1.ID_TRAM                              arc_id,
        T1.ID_TRAM                              code,
        CASE 
          -- WHEN T1.TIPUS_NODE1 IS NOT NULL AND T1.ID_NODE1 IS NOT NULL THEN T1.TIPUS_NODE1 || '_' || T1.ID_NODE1
          -- ELSE null
          WHEN T1.TIPUS_NODE1 IS NULL OR T1.ID_NODE1 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE1
          WHEN SUBSTR(T1.TIPUS_NODE1,0,4) = 'NODE' AND T6.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE1
          ELSE 'zERR ' || T1.TIPUS_NODE1 || '_' || T6.NODE_TIPUS || '_' || T1.ID_NODE1
        END                                     node_1,
        CASE 
          -- WHEN T1.TIPUS_NODE2 IS NOT NULL AND T1.ID_NODE2 IS NOT NULL THEN T1.TIPUS_NODE2 || '_' || T1.ID_NODE2
          -- ELSE null
          WHEN T1.TIPUS_NODE2 IS NULL OR T1.ID_NODE2 IS NULL THEN null
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BINC' THEN 'HIDRANT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CELE' THEN 'BOMBAMENT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'CAPT' THEN 'CAPTACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'COMP' THEN 'COMPTADOR' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'DIPO' THEN 'DIPOSIT' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'POUS' THEN 'POU' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'PCON' THEN 'POU_CONN' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'REDU' THEN 'REDUCCIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'TAPS' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VALV' THEN 'VALVULA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VDES' THEN 'VDESCARREGA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'VENT' THEN 'VENTOSA' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'BREG' THEN 'GREENTAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'FONT' THEN 'TAP' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = '-' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'A' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'C' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'D' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'I' THEN 'INICI_FI' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'S' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'T' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'U' THEN 'UNIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'V' THEN 'DERIVACIO' || '_' || T1.ID_NODE2
          WHEN SUBSTR(T1.TIPUS_NODE2,0,4) = 'NODE' AND T7.NODE_TIPUS = 'X' THEN 'CREUAMENT' || '_' || T1.ID_NODE2
          ELSE 'zERR ' || T1.TIPUS_NODE2 || '_' || T7.NODE_TIPUS || '_' || T1.ID_NODE2
        END                                     node_2,
        T1.ID_MATERIAL || '_' ||
         CASE
           WHEN T4.TIPUS='E' THEN T1.DIAMETRE_EXT
           ELSE T1.DIAMETRE_NOM
         END                                    arccat_id,
        'VARC'                                  cat_arctype_id,       
        '-'                                     matcat_id,
        '-'                                     cat_pnom,
        '-'                                     cat_dnom,
        null                                    epa_type,
        T8.SECTOR_ID                            sector_id,
        T8.MACROSECTOR_ID                       macrosector_id,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                     state,
        CASE
          WHEN T1.ESTAT = 'B' THEN 0    
          ELSE 11
        END                                     state_type,
        null                                    annotation,
        null                                    observ,
        null                                    "comment",
        CAST(null AS NUMBER)                    gis_length,
        T1.LONGITUD                             custom_length,
        300                                     dma_id,
        T9.ID                                   presszonecat_id,
        null                                    soilcat_id,
        null                                    function_type,
        null                                    category_type,
        null                                    fluid_type,
        null                                    location_type,
        T1.EXPEDIENT                            workcat_id,
        T1.EXPBAIXA                             workcat_id_end,
        null                                    buildercat_id,
        T1.DATA_INST                            builtdate,
        T1.DATA_BAIXA                           enddate,
        null                                    ownercat_id,
        3                                       muni_id,
        CAST(null AS INTEGER)                   postcode,
        null                                    streetaxis_id,
        CAST(null AS INTEGER)                   postnumber,
        null                                    postcomplement,
        null                                    streetaxis2_id,
        CAST(null AS INTEGER)                   postnumber2,
        null                                    postcomplement2,
        null                                    descript,
        '-'                                     link,
        null                                    verified,
        T2.THE_GEOM                             the_geom,
        null                                    undelete,        
        null                                    label_x,
        null                                    label_y,
        CAST(null AS NUMBER)                    label_rotation,
        'true'                                  publish,
        'true'                                  inventory,
        T1.ZONA                                 macrodma_id,
        3                                       expl_id,
        CAST(null AS NUMBER)                    num_value
FROM    NA_LLISSADEVALL.NA_V_TRAM T1
          LEFT JOIN LLISSA_NA3_T_TRAM T2 ON T1.ID_TRAM = T2.ID_TRAM
          LEFT JOIN NA_LLISSADEVALL.CAT_T_MATERIAL T4 ON T1.ID_MATERIAL = T4.ID_MATERIAL
          LEFT JOIN NA_LLISSADEVALL.CAT_T_SUBXARXA T5 ON T1.ID_SUBXARXA = T5.ID_SUBXARXA
          LEFT JOIN NA_LLISSADEVALL.NA_V_NODE T6 ON T1.ID_NODE1 = T6.ID_NODE AND T1.TIPUS_NODE1 = 'NODE'
          LEFT JOIN NA_LLISSADEVALL.NA_V_NODE T7 ON T1.ID_NODE2 = T7.ID_NODE AND T1.TIPUS_NODE2 = 'NODE'
          LEFT JOIN CAT_PRESSZONE T9 ON T1.ID_SUBXARXA = T9.LINK
          LEFT JOIN SECTOR T8 ON T9.ID = T8.DESCRIPT
WHERE   T1.ID_SUBXARXA LIKE '%T'
  
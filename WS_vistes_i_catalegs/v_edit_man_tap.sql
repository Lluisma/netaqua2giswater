

CREATE OR REPLACE VIEW V_EDIT_MAN_TAP AS

SELECT  T1.ID_FONT                              connec_id,
        CASE
          WHEN T1.CODI_LAB IS NULL THEN ROWNUM*-1
          ELSE T1.CODI_LAB
        END                                     code,
        CAST(null AS NUMBER)                    elevation,
        CAST(null AS NUMBER)                    depth,
        CASE
          WHEN T1.TIPUS='AG' THEN 'ABEURADOR'
          ELSE 'FONT'
        END                                     connectype_id,
        CASE
          WHEN T3.FONT_TIPUS IS NULL THEN 'FONT_XX'
          WHEN T1.TIPUS = 'AL' THEN 'FONT_XX'
          WHEN T1.TIPUS = 'AG' THEN 'ABEU_XX'
          ELSE REPLACE(REPLACE(SUBSTR(T3.FONT_TIPUS, INSTR(T3.FONT_TIPUS,' - ')+3), ' '),'À','A')
        END                                     connecat_id,
        '-'                                     matcat_id,
        '-'                                     pnom,
        '-'                                     dnom,
        1                                       sector_id,
        1                                       macrosector_id,
        T1.CODI_LAB                             customer_code,
        CAST(null AS NUMBER)                    n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                     state,
        CAST(null AS SMALLINT)                  state_type,
        SET_PART(T1.OT_PART)                    annotation,
        T1.OBS                                  observ,
        SET_PART(T1.OT_BAIXA_PART)              "comment",
        CAST(null AS INTEGER)                   dma_id,
        REPLACE(T1.PIS_PRES,'PIS','M_')         presszonecat_id,
        null                                    soilcat_id,
        null                                    function_type,
        T1.CONNEXIO                             category_type,
        null                                    fluid_type,
        null                                    location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          ELSE T1.EXPEDIENT
        END                                     workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          ELSE T1.EXPBAIXA
        END                                     workcat_id_end,
        null                                    buildercat_id,
        T1.DATA_INST                            builtdate,
        T1.DATA_BAIXA                           enddate,
        null                                    ownercat_id,
        1                                       muni_id,
        CASE
          WHEN (T1.CARRER1 IS NOT NULL AND T1.CARRER1 <> '0') THEN REPLACE(T1.CARRER1,',1','')
          ELSE null
        END                                     streetaxis_id,
        CAST(null AS NUMBER)                    postnumber,
        null                                    postcomplement,
        CASE
          WHEN (T1.CARRER2 IS NOT NULL AND T1.CARRER2 <> '0') THEN REPLACE(T1.CARRER2,',1','')
          ELSE null
        END                                     streetaxis2_id,
        CAST(null AS NUMBER)                    postnumber2,
        null                                    postcomplement2,
        T1.SITUACIO                             descript,
        null                                    arc_id,
        '-'                                     svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)            rotation,
        null                                    label_x,
        null                                    label_y,
        CAST(null AS NUMBER)                    label_rotation,
        '-'                                     link,
        T1.ESC_LONG                             connec_length,
        null                                    verified,
        T2.XY_GEO                               the_geom,
        null                                    undelete,
        'true'                                  publish,
        CASE T1.INVENTARI
          WHEN 'DE' THEN 'false'
          ELSE 'true'
        END                                     inventory,
        CAST(null AS NUMBER)                    macrodma_id,
        1                                       expl_id,
        T1.ESC_DIAM                             num_value,
        T1.ESCOMESA                             linked_connec,
        CASE T1.ARQ_VALV
          WHEN 'NO' THEN null
          WHEN 'B' THEN 'VALV_B_XX'
          WHEN 'C' THEN 'VALV_C-XX'
          ELSE 'VALV_XX'
        END                                     cat_valve,
        T1.DESG_DIAM                            drain_diam,
        T1.DESG_SORT                            drain_exit,
        T1.DESG_REIXA                           drain_gully,
        T1.DESG_DIST                            drain_distance,
        CASE T1.PATRIMONI_ARQUITEC
          WHEN 'SI' THEN 'true'
          WHEN 'NO' THEN 'false'
          ELSE null
        END                                     arq_patrimony,
        T1.COMUNICACIO                          com_state
FROM    NA_MATARO.NA_V_FONT T1
          LEFT JOIN NA_MATARO.NA3_T_FONT T2 ON T1.ID_FONT = T2.ID_FONT
          LEFT JOIN NA_MATARO.CAT2_T_FONT_TIPUS T3 ON T1.TIPUS = T3.ID_FONT_TIPUS;

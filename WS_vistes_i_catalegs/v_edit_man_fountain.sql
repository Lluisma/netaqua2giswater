
CREATE OR REPLACE VIEW V_EDIT_MAN_FOUNTAIN AS

SELECT  T1.ID_FOOR                           connec_id,
        T1.ID_FOOR                           code,
        CAST(null AS NUMBER)                 elevation,
        CAST(null AS NUMBER)                 depth,
        'FONT_ORN'                           connectype_id,
        'FOOR_XX'                            connecat_id,
        '-'                                  matcat_id,
        '-'                                  pnom,
        '-'                                  dnom,
        1                                    sector_id,
        1                                    macrosector_id,
        T1.CODI_MAX                          customer_code,
        CAST(null AS NUMBER)                 n_hydrometer,
        CASE T1.ESTAT
          WHEN 'A' THEN 1
          WHEN 'B' THEN 0
          ELSE -1
        END                                  state,
        CASE T1.ESTAT
          WHEN 'A' THEN 11
          ELSE null
        END                                  state_type,
        null                                 annotation,
        null                                 observ,
        null                                 "comment",
        CAST(null AS INTEGER)                dma_id,
        REPLACE(T1.PIS_PRES,'PIS','M_')      presszonecat_id,
        null                                 soilcat_id,
        null                                 function_type,
        T1.CONNEXIO                          category_type,
        null                                 fluid_type,
        null                                 location_type,
        CASE 
          WHEN T1.EXPEDIENT = '0' THEN null
          WHEN T1.OT_PART IS NOT NULL AND T1.OT_PART <> 0 THEN T1.EXPEDIENT || '-' || T1.OT_PART
          ELSE T1.EXPEDIENT
        END                                  workcat_id,
        CASE 
          WHEN T1.EXPBAIXA = '0' THEN null
          WHEN T1.OT_BAIXA_PART IS NOT NULL AND T1.OT_BAIXA_PART <> 0 THEN T1.EXPBAIXA || '-' || T1.OT_BAIXA_PART
          ELSE T1.EXPBAIXA
        END                                  workcat_id_end,
        null                                 buildercat_id,
        T1.DATA_INST                         builtdate,
        T1.DATA_BAIXA                        enddate,
        null                                 ownercat_id,
        1                                    muni_id,
        TO_NUMBER(REPLACE(CARRER1,',1',''))  streetaxis_id,
        CAST(null AS INTEGER)                postnumber,
        null                                 postcomplement,
        TO_NUMBER(REPLACE(CARRER2,',1',''))  streetaxis2_id,
        CAST(null AS INTEGER)                postnumber2,
        null                                 postcomplement2,
        T1.INDRET                            descript,
        null                                 arc_id,
        '-'                                  svg,
        MOD(T1.ANGLE_ROTACIO*-1,360)         rotation,
        null                                 label_x,
        null                                 label_y,
        CAST(null AS NUMBER)                 label_rotation,
        '-'                                  link,
        CAST(null AS NUMBER)                 connec_length,
        null                                 verified,
        T2.XY_GEO                            the_geom,
        null                                 undelete,
        'true'                               publish,
        'true'                               inventory,
        CAST(null AS NUMBER)                 macrodma_id,
        1                                    expl_id,
        CAST(null AS NUMBER)                 num_value,
        null                                 pol_id,
        T1.ESCOMESA_NUM                      linked_connec,
        T1.CAPACITAT                         vmax,
        T1.CAPACITAT_TOTAL                   vtotal,
        T1.NUM_VASOS                         container_number,
        T1.NUM_BOMBES                        pump_number,
        T1.POTENCIA                          power,
        T1.DIPOSIT_REGULADOR                 regulation_tank,
        T1.CLORADOR                          chlorinator,
        null                                 arq_patrimony,
        T1.NOM                               name
   FROM NA_MATARO.NA_V_FOOR T1
          LEFT JOIN NA_MATARO.NA3_T_FOOR T2 ON T1.ID_FOOR = T2.ID_FOOR;


CREATE OR REPLACE VIEW CAT_ARC_SHAPE AS

	SELECT 	ID_TSEC                     AS "id",
    			CASE ID_TSEC
            WHEN 'ARCO'        THEN 'ARCH'
            WHEN 'ALTRES'      THEN 'IRREGULAR'
            WHEN 'CIRCULAR'    THEN 'CIRCULAR'
            WHEN 'DESVIAMENT'  THEN 'CUSTOM'
            WHEN 'GALERIA'     THEN 'RECT_ROUND'
            WHEN 'GALERIA2'    THEN 'RECT_ROUND'
            WHEN 'OVOIDE'      THEN 'EGG'
            WHEN 'QUADRADA'    THEN 'RECT_CLOSED'
            WHEN 'RECTANGULAR' THEN 'RECT_CLOSED'
            WHEN 'RIERES'      THEN 'IRREGULAR'
            WHEN 'TRIANGULAR'  THEN 'TRIANGULAR'
            ELSE null
          END                         AS "epa",
          null                        AS "tsect_id",
          null                        AS "curve_id",
    			CASE ID_TSEC
            WHEN 'ARCO'        THEN 'ud_section_arch.png'
            WHEN 'ALTRES'      THEN 'ud_section_irregular.png'
            WHEN 'CIRCULAR'    THEN 'ud_section_circular.png'
            WHEN 'DESVIAMENT'  THEN 'ud_section_custom.png'
            WHEN 'GALERIA'     THEN 'ud_section_rect_round.png'
            WHEN 'GALERIA2'    THEN 'ud_section_rect_round.png'
            WHEN 'OVOIDE'      THEN 'ud_section_egg.png'
            WHEN 'QUADRADA'    THEN 'ud_section_rect_closed.png'
            WHEN 'RECTANGULAR' THEN 'ud_section_rect_closed.png'
            WHEN 'RIERES'      THEN 'ud_section_irregular.png'
            WHEN 'TRIANGULAR'  THEN 'ud_section_triangular.png'
            ELSE null
          END                         AS "image",
          INITCAP( ID_TSEC )          AS "descript",
        	'true'                      AS "active"
	FROM   	NS_MATARO.CAT_TRAM_SECCIO
	ORDER BY 1;

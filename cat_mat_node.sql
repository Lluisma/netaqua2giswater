
-- TAULA BUIDA

CREATE OR REPLACE VIEW CAT_MAT_NODE AS

    SELECT DISTINCT MATCAT_ID              id,
           SUBSTR( SUBSTR(DESCRIPT, INSTR(DESCRIPT,':')+2), 0, INSTR( SUBSTR(DESCRIPT, INSTR(DESCRIPT,':')+2), '-')-2)          descript,
           NULL              link
    FROM   CAT_CONNEC
    WHERE  MATCAT_ID IS NOT NULL;
  
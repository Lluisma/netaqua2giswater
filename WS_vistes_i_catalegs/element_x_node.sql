
CREATE OR REPLACE VIEW ELEMENT_X_NODE AS

  SELECT ROWNUM id, element_id, node_id 
  FROM (
  
    -- BINC : TRAPA

    SELECT  'ARQB_1_' || T1.ID_BINC          element_id,
            '1_HIDRANT_' || T1.ID_BINC       node_id
    FROM    NA_MATARO.NA_V_BINC T1
    WHERE   T1.TRAPA IS NOT NULL
       
    -- VENT : TRAPA
    
    UNION
  
    SELECT  'ARQV_1_' || T1.ID_VENT          element_id,
            '1_VENTOSA_' || T1.ID_VENT       node_id
    FROM    NA_MATARO.NA_V_VENT T1
    WHERE   T1.TRAPA IS NOT NULL
          
    -- VDES : ARQUETA + MAT_TAPA
  
    UNION
    
    SELECT  'ARQ_1_' || T1.ID_VDES           element_id,
            '1_VDESCARREGA_' || T1.ID_VDES   node_id
    FROM    NA_MATARO.NA_V_VDES T1
    WHERE   T1.ARQUETA IS NOT NULL OR T1.MAT_TAPA IS NOT NULL
    
    -- VALV : ARQUETA
  
    UNION
    
    SELECT  'ARQL_1_' || T1.ID_VALV          element_id,
            '1_VALVULA_' || T1.ID_VALV       node_id
    FROM    NA_MATARO.NA_V_VALV T1
    WHERE   T1.ARQUETA IS NOT NULL
    
  );
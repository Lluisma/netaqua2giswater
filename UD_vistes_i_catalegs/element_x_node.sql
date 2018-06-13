
CREATE OR REPLACE VIEW ELEMENT_X_NODE AS

  SELECT ROWNUM id, element_id, node_id 
  FROM (
  
    -- TAPA

    SELECT  'TAPA_' || T1.ID_NODE     AS element_id,
            T1.ID_NODE                AS node_id
    FROM    NS_MATARO.CL_V_NODE T1
    WHERE   T1.TAPA_MAT IS NOT NULL 
       OR   T1.TAPA_SEC IS NOT NULL
       OR   T1.TAPA_DIM IS NOT NULL
       
    -- GRAONS
    
    UNION
  
    SELECT  'GRAO_' || T1.ID_NODE     AS element_id,
            T1.ID_NODE                AS node_id
    FROM    NS_MATARO.CL_V_NODE T1
    WHERE   T1.GRAONS_MAT IS NOT NULL  OR  (T1.GRAONS_NUM IS NOT NULL AND T1.GRAONS_NUM>0)
 
  );
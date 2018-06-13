
CREATE OR REPLACE VIEW MAN_TYPE_FLUID AS 

	SELECT  1    			                         id,
			    'PLUVIAL'	                         fluid_type,
			    'CONNEC'                           feature_type,
			    'CONNEC'                           featurecat_id,
			    'Aig�es pluvials'                  observ
	FROM 	  DUAL
  UNION
  SELECT  2, 'RESIDUAL', 'CONNEC', 'CONNEC' , 'Xarxa Residual'
  FROM DUAL
  UNION
  SELECT  3, 'UNITARIA', 'CONNEC', 'CONNEC' , 'Xarxa Unit�ria'
  FROM DUAL
       
  UNION
    
  SELECT  4, 'PLUVIAL',  'ARC',    'CONDUIT', 'Pluvial'
  FROM    DUAL
  UNION
  SELECT  5, 'RESIDUAL', 'ARC',    'CONDUIT', 'Residual'
  FROM    DUAL
  UNION
  SELECT  6, 'UNITARIA', 'ARC',    'CONDUIT', 'Unit�ria'
  FROM    DUAL;
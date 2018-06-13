
CREATE OR REPLACE VIEW MAN_TYPE_FLUID AS 

	SELECT  1    			                         id,
			    'PLUVIAL'	                         fluid_type,
			    'CONNEC'                           feature_type,
			    'CONNEC'                           featurecat_id,
			    'Aigües pluvials'                  observ
	FROM 	  DUAL
  UNION
  SELECT  2, 'RESIDUAL', 'CONNEC', 'CONNEC' , 'Xarxa Residual'
  FROM DUAL
  UNION
  SELECT  3, 'UNITARIA', 'CONNEC', 'CONNEC' , 'Xarxa Unitària'
  FROM DUAL
       
  UNION
    
  SELECT  4, 'PLUVIAL',  'ARC',    'CONDUIT', 'Pluvial'
  FROM    DUAL
  UNION
  SELECT  5, 'RESIDUAL', 'ARC',    'CONDUIT', 'Residual'
  FROM    DUAL
  UNION
  SELECT  6, 'UNITARIA', 'ARC',    'CONDUIT', 'Unitària'
  FROM    DUAL;
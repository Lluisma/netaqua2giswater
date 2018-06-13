

CREATE OR REPLACE VIEW GW_MIGRA_NETAQUA.SELECTOR_HYDROMETER AS
	SELECT  1 					AS id,
			1 					AS state_id, 
			'amsaadmin' 		AS cur_user 
	FROM DUAL
  	UNION
  	SELECT 2, 1, 'bgeoadmin' 
  	FROM DUAL;
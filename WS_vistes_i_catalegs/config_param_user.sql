
CREATE OR REPLACE VIEW CONFIG_PARAM_USER AS

  SELECT  1                       AS  "id",
          'virtual_layer_point'   AS "parameter",
          'point'                 AS "value",
          'amsaadmin'             AS cur_user  
  FROM DUAL
  UNION
  SELECT  2, 'state_vdefault',        '1',      'amsaadmin'
  FROM DUAL
  UNION
  SELECT  3, 'statetype_vdefault',    '11',     'amsaadmin'
  FROM DUAL
  UNION
  SELECT  4, 'workcat_vdefault',      'AE1001', 'amsaadmin'
  FROM DUAL
  UNION
  SELECT  5, 'virtual_layer_polygon', 'circle', 'amsaadmin'
  FROM DUAL
  UNION
  SELECT  6, 'exploitation_vdefault', '1',      'amsaadmin'
  FROM DUAL
  UNION
  SELECT  7, 'municipality_vdefault', '1',      'amsaadmin'
  FROM DUAL
  UNION
  SELECT  8, 'dma_vdefault',          '100',    'amsaadmin'
  FROM DUAL
  UNION
  SELECT  9, 'sector_vdefault',       '21',     'amsaadmin'
  FROM DUAL
  UNION
  SELECT 10, 'psector_vdefault',      '5',      'amsaadmin'
  FROM DUAL
  UNION
  SELECT 11, 'statetype_vdefault',    '11',     'amsaadmin'
  FROM DUAL;


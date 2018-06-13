
CREATE OR REPLACE VIEW CAT_ARC_CLASS AS

    SELECT null                       AS "id",
           null                       AS arccat_id,
           null                       AS class_type,
           null                       AS catclass_id
    FROM   DUAL
    WHERE  1=2;


CREATE OR REPLACE VIEW CAT_ARC_CLASS_CAT AS

    SELECT null                       AS "id",
           null                       AS class_type,
           null                       AS catclass_id,
           null                       AS "name",
           null                       AS from_val,
           null                       AS to_val,
           null                       AS observ
    FROM   DUAL
    WHERE  1=2;
    
    
CREATE OR REPLACE VIEW CAT_ARC_CLASS_TYPE AS

    SELECT null                       AS "id",
           null                       AS "name",
           null                       AS observ
    FROM   DUAL
    WHERE  1=2;

CREATE TABLE PLAN_PSECTOR
  (
    "PSECTOR_ID"   NUMBER NOT NULL ENABLE,
    "name"         VARCHAR2(50 BYTE) NOT NULL ENABLE,
    "PSECTOR_TYPE" NUMBER,
    "DESCRIPT"     VARCHAR2(50 BYTE),
    "EXPL_ID"      NUMBER NOT NULL ENABLE,
    "PRIORITY"     VARCHAR2(16 BYTE),
    "TEXT1"        VARCHAR2(50 BYTE),
    "TEXT2"        VARCHAR2(50 BYTE),
    "OBSERV"       VARCHAR2(50 BYTE),
    "ROTATION"     NUMBER(8,4),
    "scale"        NUMBER(8,2),
    "SECTOR_ID"    NUMBER NOT NULL ENABLE,
    "ATLAS_ID"     VARCHAR2(16 BYTE),
    "GEXPENSES"    NUMBER(4,2),
    "VAT"          NUMBER(4,2),
    "OTHER"        NUMBER(4,2),
    "ACTIVE"       VARCHAR2(5 BYTE),
    "THE_GEOM" "SDO_GEOMETRY",
    "ENABLE_ALL" VARCHAR2(5 BYTE),
    CONSTRAINT "PLAN_PSECTOR_PKEY" PRIMARY KEY ("PSECTOR_ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "USERS" ENABLE
  )
  SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
  )
  TABLESPACE "USERS" ;
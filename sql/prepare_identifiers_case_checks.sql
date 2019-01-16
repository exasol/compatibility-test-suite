-- This script creates a schema and table for all basic types datasets that use up the maximum size for that datatype.
--
-- We intentionally create tables with names that only differ in the case of the letters to check whether the client
-- can handle case sensitivity. 
DROP SCHEMA IF EXISTS "EXASOL_CT_ObjectNameCase" CASCADE;

CREATE SCHEMA "EXASOL_CT_ObjectNameCase";

OPEN SCHEMA "EXASOL_CT_ObjectNameCase";

CREATE TABLE "READ_TABLE_MixedCase" (
    "C_CHAR_MixedCase" CHAR(20)
);

CREATE TABLE "WRITE_TABLE_MixedCase" LIKE "READ_TABLE_MixedCase";

CREATE TABLE "READ_TABLE_mixedcase" (
    "C_CHAR_mixedcase" CHAR(20),
    "C_CHAR_MixedCase" CHAR(40),
    C_CHAR_MixedCase CHAR(60)
);

CREATE TABLE "WRITE_TABLE_mixedcase" LIKE "READ_TABLE_mixedcase";

-- Since the next table name is not enclosed in double quotes, Exasol automatically converts it to upper case.
CREATE TABLE READ_TABLE_MixedCase (
    C_CHAR_MixedCase CHAR(60)
);

CREATE TABLE WRITE_TABLE_MixedCase LIKE READ_TABLE_MixedCase;

INSERT INTO "READ_TABLE_MixedCase" VALUES ('Quoted, mixed case');
INSERT INTO "READ_TABLE_mixedcase" VALUES ('Quoted, lower case', 'Quoted, mixed case', 'Not quoted, automatically turned to upper case');
INSERT INTO READ_TABLE_MixedCase VALUES ('Not quoted, automatically turned to upper case');
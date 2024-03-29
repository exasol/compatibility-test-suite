-- This script creates a schema and table with ASCII characters in the object names.
-- The table also contains values with ASCII characters.
DROP SCHEMA IF EXISTS "EXASOL_CT_ASCII" CASCADE;

CREATE SCHEMA "EXASOL_CT_ASCII";

OPEN SCHEMA "EXASOL_CT_ASCII";

CREATE TABLE "READ_TABLE_ASCII" (
    "C_CHAR_ASCII" CHAR(40) ASCII,
    "C_VARCHAR_ASCII" VARCHAR(40) ASCII
);

CREATE TABLE "WRITE_TABLE_ASCII" LIKE "READ_TABLE_ASCII";

INSERT INTO "READ_TABLE_ASCII" VALUES ('ABC', ' !"#$...[|}~');

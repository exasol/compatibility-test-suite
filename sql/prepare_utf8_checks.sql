-- This script creates a schema and table with UTF-8 characters in the object names.
-- The table also contains values with UTF-8 characters.
DROP SCHEMA IF EXISTS "EXASOL_CT_UTF8_☺" CASCADE;

CREATE SCHEMA "EXASOL_CT_UTF8_☺";

OPEN SCHEMA "EXASOL_CT_UTF8_☺";

CREATE TABLE "READ_TABLE_UTF8_☺" (
    "C_CHAR_UTF8_☺" CHAR(40) UTF8,
    "C_VARCHAR_UTF8_☺" VARCHAR(40) UTF8
);

CREATE TABLE "WRITE_TABLE_UTF8_☺" LIKE "READ_TABLE_UTF8_☺";

INSERT INTO "READ_TABLE_UTF8_☺" VALUES ('ÄäÖöÜüß / ☺', '✅✍❠ / ÄäÖöÜüß');
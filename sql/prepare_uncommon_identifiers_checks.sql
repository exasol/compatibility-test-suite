-- This script creates Objects with identifiers outside the typical "English letters and Arabian numbers" scheme.
DROP SCHEMA IF EXISTS "EXASOL_CT_@table" CASCADE;

CREATE SCHEMA "EXASOL_CT_@table";

OPEN SCHEMA "EXASOL_CT_@table";

CREATE TABLE "READ_TABLE_@table" (
    "a-person@organization" VARCHAR(20),
    "Happy new year!" VARCHAR(20)
);

CREATE TABLE "WRITE_TABLE_@table" LIKE "READ_TABLE_@table";

CREATE TABLE "READ_TABLE_繁體中文" (
    "一個人@组织" VARCHAR(40),
    "新年快樂！" VARCHAR(40)
);

CREATE TABLE "WRITE_TABLE_繁體中文" LIKE "READ_TABLE_繁體中文";

CREATE TABLE "READ_TABLE_QUOTE""CONTAINED" (
    "C_DOUBLE_QUOTE""CONTAINED" VARCHAR(20),
    "C_SINGLE_QUOTE'CONTAINED" VARCHAR(20),
    "C_TICKS`AND´CONTAINED" VARCHAR(40)
);

CREATE TABLE "WRITE_TABLE_QUOTE""CONTAINED" LIKE "READ_TABLE_QUOTE""CONTAINED";

INSERT INTO "READ_TABLE_@table" VALUES ('@ English', 'Text English');
INSERT INTO "READ_TABLE_繁體中文" VALUES ('@ Traditional Chinese', 'Text Traditional Chinese');
INSERT INTO "READ_TABLE_QUOTE""CONTAINED" VALUES('Double', 'Single', 'Forwared / backward tick')
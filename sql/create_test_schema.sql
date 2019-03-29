-- Note that the Camel Case and Snake Case are mixed here on
-- purpose to see if they are handled correctly by the client.
DROP SCHEMA IF EXISTS "Exasol_Compliance_Test" CASCADE;

CREATE SCHEMA "Exasol_Compliance_Test";

CREATE TABLE "BooleanType" (
    c_boolean BOOLEAN
);

CREATE TABLE "CharacterTypes" (
    c_char20 CHAR(20),
    c_varchar40 VARCHAR(40)
);

CREATE TABLE "NumericTypes" (
    c_int INTEGER, -- alias for DECIMAL(18,0)
    c_decimal DECIMAL(3,2),
    c_double DOUBLE PRECISION
);

CREATE TABLE "MediumNumericTypes" (
    c_big_integer DECIMAL(28,0),
    c_big_decimal DECIMAL(28,3)
);


CREATE TABLE "BigNumericTypes" (
    c_big_integer DECIMAL(36,0),
    c_big_decimal DECIMAL(36,3)
);

CREATE TABLE "DateTimeTypes" (
    c_date DATE,
    c_timestamp TIMESTAMP,
    c_timestamp_tz TIMESTAMP WITH LOCAL TIME ZONE,
    c_intv_d2s INTERVAL DAY (9) TO SECOND,
    c_intv_y2m INTERVAL YEAR (9) TO MONTH
);

CREATE TABLE "GeometryTypes" (
    c_geomentry GEOMETRY
);

INSERT INTO "Exasol_Compliance_Test"."BooleanType" VALUES(NULL);
INSERT INTO "Exasol_Compliance_Test"."BooleanType" VALUES(true);
INSERT INTO "Exasol_Compliance_Test"."BooleanType" VALUES(false);

INSERT INTO "Exasol_Compliance_Test"."CharacterTypes" VALUES(NULL, NULL);
INSERT INTO "Exasol_Compliance_Test"."CharacterTypes" VALUES('', '');
INSERT INTO "Exasol_Compliance_Test"."CharacterTypes" VALUES('0123456789a123456789', '0123456789a123456789b123456789c123456789');

INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(0, 1.23, 3.14159265358979323846264338327950288);
INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(0, 0.0, 0.0);
INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(-555555555555555555, -9.99, -5.555555555555);
INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(-111111111111111111, -1.11, -111.11111111111);
INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(999999999999999999, 9.99, 9.9999999999999);
INSERT INTO "Exasol_Compliance_Test"."NumericTypes" VALUES(-999999999999999999, -9.99, -9.9999999999999);

INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(0, 0);
INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(1, 1);
INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(-1, -1);
INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(-1, -1);
INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(9999999999999999999999999999, 999999999999999999999999.999);
INSERT INTO "Exasol_Compliance_Test"."MediumNumericTypes" VALUES(-9999999999999999999999999999, -999999999999999999999999.999);

-- Big integers are only supported with up to 28 digits.
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(0, 0);
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(1, 1);
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(-1, -1);
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(-1, -1);
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(999999999999999999999999999999999999, 999999999999999999999999999999999.999);
INSERT INTO "Exasol_Compliance_Test"."BigNumericTypes" VALUES(-999999999999999999999999999999999999, -999999999999999999999999999999999.999);

INSERT INTO "Exasol_Compliance_Test"."DateTimeTypes" VALUES ('0001-01-01', '0001-01-01 01:01:01.000001', '1-01-01 01:01:01.001', '2 02:02:02.0002', '3-03');
INSERT INTO "Exasol_Compliance_Test"."DateTimeTypes" VALUES ('0001-01-01', '0001-01-01 01:01:01.000001', '4-04-04 04:04:04.004', '-5 05:05:05.0005', '-6-06');
INSERT INTO "Exasol_Compliance_Test"."DateTimeTypes" VALUES ('1970-01-01', '2001-01-01 01:01:01', '9999-12-31 23:59:59', '00 00:00:00', '00-00');
INSERT INTO "Exasol_Compliance_Test"."DateTimeTypes" VALUES ('9999-12-31', '2001-01-01 01:01:01.000001', '9999-12-31 23:59:59.999999', '999999999 23:59:59', '999999999-11');
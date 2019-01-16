DROP SCHEMA IF EXISTS EXASOL_CT_BASIC_TYPES CASCADE;

CREATE SCHEMA EXASOL_CT_BASIC_TYPES;

OPEN SCHEMA EXASOL_CT_BASIC_TYPES;

CREATE TABLE READ_BOOLEAN (
    C_BOOLEAN BOOLEAN
);

CREATE TABLE WRITE_BOOLEAN LIKE READ_BOOLEAN;

CREATE TABLE READ_CHARACTER (
    C_CHAR20 CHAR(20),
    C_VARCHAR20 VARCHAR(20)
);

CREATE TABLE WRITE_CHARACTER LIKE READ_CHARACTER;

CREATE TABLE READ_NUMERIC (
    C_DECIMAL DECIMAL(3,2),
    C_DOUBLE DOUBLE PRECISION
);

CREATE TABLE WRITE_NUMERIC LIKE READ_NUMERIC;

CREATE TABLE READ_DATE_TIME (
    C_DATE DATE,
    C_TIMESTAMP TIMESTAMP,
    C_TIMESTAMP_TZ TIMESTAMP WITH LOCAL TIME ZONE,
    C_INTV_D2S INTERVAL DAY (9) TO SECOND,
    C_INTV_Y2M INTERVAL YEAR (9) TO MONTH
);

CREATE TABLE WRITE_DATE_TIME LIKE READ_DATE_TIME;

CREATE TABLE READ_GEOMETRY (
    C_GEOMENTRY GEOMETRY
);

CREATE TABLE WRITE_GEOMETRY LIKE READ_GEOMETRY;

INSERT INTO READ_BOOLEAN VALUES(NULL);
INSERT INTO READ_BOOLEAN VALUES(true);
INSERT INTO READ_BOOLEAN VALUES(false);

INSERT INTO READ_CHARACTER VALUES(NULL, NULL);
INSERT INTO READ_CHARACTER VALUES('foo', 'bar');
INSERT INTO READ_CHARACTER VALUES('0123456789abcdefghij', 'ABCEDFGHIJ0123456789');

INSERT INTO READ_NUMERIC VALUES(NULL, NULL);
INSERT INTO READ_NUMERIC VALUES(1.23, 3.14159265358979323846264338327950288);
INSERT INTO READ_NUMERIC VALUES(0.0, 0.0);
INSERT INTO READ_NUMERIC VALUES(-9.99, -5.555555555555);
INSERT INTO READ_NUMERIC VALUES(-1.11, -111.11111111111);
INSERT INTO READ_NUMERIC VALUES(9.99, 9.9999999999999);
INSERT INTO READ_NUMERIC VALUES(-9.99, -9.9999999999999);

INSERT INTO READ_DATE_TIME VALUES(NULL, NULL, NULL, NULL, NULL);
INSERT INTO READ_DATE_TIME VALUES('0001-01-01', '0001-01-01 01:01:01.000001', '1-01-01 01:01:01.001', '2 02:02:02.0002', '3-03');
INSERT INTO READ_DATE_TIME VALUES('0001-01-01', '0001-01-01 01:01:01.000001', '4-04-04 04:04:04.004', '-5 05:05:05.0005', '-6-06');
INSERT INTO READ_DATE_TIME VALUES('1970-01-01', '2001-01-01 01:01:01', '9999-12-31 23:59:59', '00 00:00:00', '00-00');
INSERT INTO READ_DATE_TIME VALUES('9999-12-31', '2001-01-01 01:01:01.000001', '9999-12-31 23:59:59.999999', '999999999 23:59:59', '999999999-11');

INSERT INTO READ_GEOMETRY VALUES('POINT(1 1)');
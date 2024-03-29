# Exasol Compatibility Test Suite

This compatibility test suite contains test datasets and sample SQL statements that you can use as a standard against which you can test database clients: ETL tools, connectors, SQL clients.

This shows how your client handles access and results when working with an Exasol database as backend.

# Test Procedures

This section explains the available test variant such as tests reading or writing datasets.

## Read Tests

1. Use the provided scripts to create schema, tables, and datasets for the read tests.
2. Read the table contents using the client under test and compare the acquired values with the originals.
3. The read tests are successful if all the following criteria are met:
    1. original and acquired values are identical
    2. list of result sets matches

## Write Tests

1. Use the provided scripts to create schema, tables, and data for comparison.
2. Write the identical datasets found in the `READ_` table to the empty `WRITE_` table
3. Compare the written datasets with the originals

You can either install and use the comparison Lua script ["compare_table_contents"](sql/test_utils.sql) or implement your own comparison. It is recommended that you use database-internal features for the actual comparison to avoid problems caused by incompatibilities between your test evaluation code and the database.

You can call the comparison function provided in the test utilities as shown below:

```sql
EXECUTE SCRIPT compare_table_contents('EXASOL_CT_PRIMITIVE_TYPES.READ_BOOLEAN',
'EXASOL_CT_PRIMITIVE_TYPES.WRITE_BOOLEAN');
```

## Interpreting the Comparison Result

The comparison result is pretty straight-forward. You get a table that contains a diff of the two tables. Entries that only exist in the left table (A) are marked with `<<<` while those that are only in the right table (B) are marked with `>>>`. In an ideal test case, both tables are identical, and you get zero result rows.

Here is an example of the result for the following two tables:

**Table A**

| Row | C1        | C2  |
|----:|-----------|-----|
|   1 | in A only | 123 |
|   2 | in both   | 456 |

**Table B**

| Row | C1        | C2  |
|----:|-----------|-----|
|   1 | in B only | 789 |
|   2 | in both   | 456 |

**Result**

![Result of the table comparison script](doc/images/table_comparison_result.png)

# Tested Aspects

This test suite contains various test scenarios to check different compliance aspects. If you just started with your compliance tests, we recommend executing the test in the following order to ensure the basics work before you proceed to work on more complex concepts.

## Basic Type Checks

Exasol database knows the following basic data types (see [Exasol User Manual][EXAMAN], sec. 2.3.1 "Overview of Exasol data types"):

* `BOOLEAN`
* `CHAR(n)`
* `DATE`
* `DECIMAL(p,s)`
* `DOUBLE PRECISION`
* `GEOMETRY[(srid)]`
* `INTERVAL DAY [(p)] TO SECOND [(fp)]`
* `INTERVAL YEAR [(p)] TO MONTH`
* `TIMESTAMP`
* `TIMESTAMP WITH LOCAL TIME ZONE`
* `VARCHAR(n)`

Any other supported type name is just an *alias* for one of these types mentioned above. The alias `INTEGER` for example is the equivalent of the basic type `DECIMAL(18,0)`.

To run basic type checks:
1.    Run [prepare_basic_type_checks.sql](sql/prepare_basic_type_checks.sql) to create a schema and tables containing the Exasol basic types including some simple values. 
2.    Run a [read](#read-tests) and [write test](#write-tests) on those datasets.

## Maximum Column Size Checks

Refer to [Exasol User Manual][EXAMAN] states in section 2.3.1. "Overview of Exasol data types" for details on the column size limits.

The script ["prepare_column_size_limit_checks.sql"](sql/prepare_column_size_limit_checks.sql) creates tables and columns with variable-size types (numeric and character types) set to their maximum size. It then fills them with content that helps you check whether your client handles them correctly.

## UTF-8 Checks

Exasol can handle character string field values containing UTF-8 characters. Additionally, it accepts UTF-8 characters in object identifiers when put in double quotes.

Use ["prepare_utf8_checks.sql"](sql/prepare_utf8_checks.sql) to create a schema, a table, and two columns all containing a UTF-8 character in their name. The columns are defined as character types that accept UTF-8 values and filled with example values. This should be enough for a basic compatibility check.

## Identifier Case Handling Checks

Exasol is case-sensitive when it comes to object identifiers. This means that a table called `"People"` can co-exist in the same schema with tables called `"people"`, `"PEOPLE"` or any other case combinations. If you want to utilize the case sensitivity, you need to enclose object names in double quotes in your SQL commands.

Exasol converts all unquoted object identifiers to upper case. The potential pitfall for a client application here is if quoting is not handled uniformly. Or if the unsuspecting user uses two clients with different behavior. If users enter SQL code in your client, the safest option here is to reproduce identifiers and optional quotes exactly as written by the users. In effect the tables `"PEOPLE"` and `people` (mind the quotes) can't coexist in the same schema.

If all code is generated in the client and users only provide object names, we recommend always quoting them – this makes the client case-sensitive. While this increases the chance of error messages, it is better than the alternative of potentially creating SQL incompatible between two clients.

The script ["prepare_identifiers_case_checks.sql"](sql/prepare_identifiers_case_checks.sql) demonstrates Exasol's case sensitivity and the auto-upper-case conversion of unquoted object names. We create table and columns that have identical names &mdash; except for the character case. This way you can test whether your client can handle case sensitivity.

## Uncommon Identifier Checks

In addition to the [case-sensitivity mentioned before](#identifier-case-handling-checks), Exasol allows a couple of variants for identifiers that you don't see very often in programming. There are [UFT-8 identifiers](#utf-8-checks) and "special characters" within the ASCII range. Quoted identifiers can, for example, contain white spaces, the "at" symbol, punctuation (except the dot symbol) and others. The double quotes can appear in quoted identifiers. Though this is flexible, you need to handle it with caution.

The script ["prepare_uncommon_identifiers_checks.sql"](sql/prepare_uncommon_identifiers_checks.sql) contains an assortment of valid examples.

## "Nullable" Checks

You can define whether NULL is a valid value for any column. If you don't state otherwise in your table creation command, by default the column is nullable in Exasol.

```sql
CREATE TABLE t1 (a DOUBLE);          -- Column can contain DOUBLE or NULL
CREATE TABLE t2 (a DOUBLE NULL);     -- Explicit way to state NULL is allowed
CREATE TABLE t3 (a DOUBLE NOT NULL); -- Column can only be DOUBLE number, not NULL
```

Use ["prepare_nullable_checks.sql"](sql/prepare_nullable_checks.sql) to create a table that has a column that can be `NULL` and one that can't.

The ETL software often needs to know whether a column is nullable or not. This allows creating SQL statements that deal with the additional corner cases when a value is `NULL`. Since the additional complexity of the statement should be avoided unless necessary, the client must get the information if a column is nullable from the database.

To do this with Exasol 6.1, query the Exasol metadata view `SYS.EXA_ALL_COLUMNS`.

Getting nullability status via `SELECT` statements is not yet supported.

An example that lists all tables inside the currently opened schema with their respective columns and whether they are allowed to contain `NULL` is given below.

```sql
SELECT COLUMN_TABLE, COLUMN_NAME, COLUMN_IS_NULLABLE
FROM SYS.EXA_ALL_COLUMNS
WHERE COLUMN_SCHEMA=CURRENT_SCHEMA;
```

One of the downsides of this is that administrator privileges are required to query the view.

# Troubleshooting

## Numeric Types and Precision

Some database clients by default limit the precision up to which numeric values are _displayed_. This does not mean they can't handle the full precision. If you come across a situation where the expected and displayed numeric value has different precisions, check if any display limits are set.

# Links

* [Exasol Database User Manual 6.1 (English)][EXAMAN]

[EXAMAN]: https://www.exasol.com/portal/download/attachments/36478050/EXASOL_User_Manual-6.1.0-en.pdf

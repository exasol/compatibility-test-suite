-- This script creates a simple diff view between two tables.
--
-- The result set contains all datasets that are not identical in both tables.
-- If a dataset exists in only in the left table, the first column of the result set is marked with "<<<".
-- In case it exists in the right table only, the marker reads ">>>".
CREATE OR REPLACE SCRIPT compare_table_contents (table_a, table_b) RETURNS TABLE AS
    exit(
       query([[
           (SELECT '<<<',
                (SELECT * FROM ::a
                EXCEPT
                SELECT * FROM ::b
                )
            )  
            UNION ALL
            (SELECT '>>>',
                (SELECT * FROM ::b
                EXCEPT
                SELECT * FROM ::a
                )
            )
        ]], {a = table_a, b = table_b}
        )
    )
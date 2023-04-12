# Compatibility Test Suite 2.0.0, released 2023-04-12

Code name: Improved documentation

## Summary

This release adds missing user documentation for `COMPARE_TABLE_CONTENTS` and the change log in the sources (was already available as GitHub releases).

We renamed the first output column of the `COMPARE_TABLE_CONTENTS` script to `A_vs_B` instead of the auto-generated `<<<` label. If you used that script inside another script and based any post-processing on the result, this is a **breaking change**. We still decided to do this because the current column name is not meaningful. Due to the breaking change we incremented the major number of the project.

## Feature

* #15: Changed name of first result column in `COMPARE_TABLE_CONTENTS` script to `A_vs_B`

## Documentation

* #15: Added user documentation for `COMPARE_TABLE_CONTENTS` and fixed typos


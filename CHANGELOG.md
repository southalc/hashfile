# Changelog

## Release 1.4.0

- Updated hash2ini function to support arrays as key values.  This results in an INI file where multiple lines in the
  same section will have the same key, but may have different values.
- Updated supported puppet versions and module dependencies.

## Release 1.3.2

- No functional changes.  Updated documentation to identify that "hash2json" function is removed 

## Release 1.3.1

- Add 'use_quotes' boolean to hash2ini function to control if INI values should be enclosed in quotes. Default is false.
  This affects the 'quote_booleans' and 'quote_numerics' options, as 'use_quotes' must be true (not default)

## Release 1.3.0

Forked from 'mmckinst-hash2stuff'
- Converted to PDK, linted, validated
- Refactored legacy 3.x functions to 4.x
- Add documentation using puppet strings
- Add support for Puppet 7 and additional operating systems
- Add defined types so supported file formats can be managed directly from hiera
- Removed hash2json function in favor of using to_json_pretty from stdlib


# Changelog

## Release 1.0.0

Forked from 'mmckinst-hash2stuff'
- Converted to PDK, linted, validated
- Refactored legacy 3.x functions to 4.x API
- Add documentation using puppet strings
- Add support for Puppet 7 and additional operating systems
- Add defined types so supported file formats can be managed directly from hiera
- Removed hash2json function in favor of using to_json_pretty from stdlib

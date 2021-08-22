# @summary Create various file formats from a source hash
#
# @param ini A data hash to be converted to ini files
#
# @param json A data hash to be converted to json files
#
# @param kv A data hash to be converted to key/value (shellvar) files
#
# @param properties A data hash to be converted to Java properties files
#
# @param yaml A data hash to be converted to yaml files
#
# @example Hiera representation of an INI file from a hash
#   hashfile::ini:
#     /tmp/file.ini:
#       file:
#         ensure: file
#         owner: root
#         group: root
#         mode: '0600'
#       data:
#         section1:
#           key1: value1
#           key2: value2
#
class hashfile  (
  Hash $ini = {},
  Hash $json = {},
  Hash $kv = {},
  Hash $properties = {},
  Hash $yaml = {},
) {
  # Create resources from parameter hashes using the defined types
  $ini.each        |$name, $hash| { Resource['Hashfile::Ini']        { $name: * => $hash, } }
  $json.each       |$name, $hash| { Resource['Hashfile::Json']       { $name: * => $hash, } }
  $kv.each         |$name, $hash| { Resource['Hashfile::Kv']         { $name: * => $hash, } }
  $properties.each |$name, $hash| { Resource['Hashfile::Properties'] { $name: * => $hash, } }
  $yaml.each       |$name, $hash| { Resource['Hashfile::Yaml']       { $name: * => $hash, } }
}

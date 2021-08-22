# @summary Defined type provides an implementation of the hash2json function, creating a JSON file from the input hash
#
# @param file Properties of the target file resource.  Accepts and requires the same parameters of a puppet "file"
#  
# @param data Hash representation of the JSON file.
#
# @example
#   hashfile::json { 'namevar':
#     file => {
#       ensure => file,
#       owner  => 'root',
#       group  => 'root',
#       mode   => '0644',
#     }
#     data => {
#       section1 => {
#         key1   => 'value1',
#       }
#     }
#   }
#
define hashfile::json (
  Hash $file,
  Hash $data,
) {
  File {$name:
    * => merge($file, content => to_json_pretty($data)),
  }
}

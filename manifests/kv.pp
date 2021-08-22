# @summary Defined type provides an implementation of the hash2kv function, creating a key-value/shellvar file from the input hash
#
# @param file Properties of the target file resource.  Accepts and requires the same parameters of a puppet "file"
#  
# @param data Hash representation of the key-value/shellvar file.
#
# @param options Hash of optional values to format output file. See "hash2kv" function for details.
#
# @example
#   hashfile::kv { 'namevar':
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
define hashfile::kv (
  Hash $file,
  Hash $data,
  Hash $options = {},
) {
  File {$name:
    * => merge($file, content => hash2kv($data, $options)),
  }
}

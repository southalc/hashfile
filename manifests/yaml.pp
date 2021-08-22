# @summary Defined type provides an implementation of the hash2yaml function, creating a YAML file from the input hash
#
# @param file Properties of the target file resource.  Accepts and requires the same parameters of a puppet "file"
#  
# @param data Hash representation of the YAML file.
#
# @param options Hash of optional values to format output file. See "hash2yaml" function for details.
#
# @example
#   hashfile::yaml { 'namevar':
#     file => {
#       ensure => file,
#       owner  => 'root',
#       group  => 'root',
#       mode   => '0644',
#     }
#     data  => {
#       section1 => {
#         key1   => 'value1',
#       }
#     }
#   }
#
define hashfile::yaml (
  Hash $file,
  Hash $data,
  Hash $options = {},
) {
  File {$name:
    * => merge($file, content => hash2yaml($data, $options)),
  }
}

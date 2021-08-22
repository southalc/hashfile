# @summary Defined type provides an implementation of the hash2ini function, creating an INI file from the input hash
#
# @param file_props Properties of the target file resource.  Accepts and requires the same parameters of a puppet "file"
#  
# @param data_hash Hash representation of the INI file, to include section names and key/value pairs
#
# @param options Optional hash of values to format output. See the "hash2ini" function for details.
#
# @example
#   hashfile::ini { '/some/file.ini':
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
define hashfile::ini (
  Hash $file,
  Hash $data,
  Hash $options = {},
) {
  File {$name:
    * => merge($file, content => hash2ini($data, $options)),
  }
}

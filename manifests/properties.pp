# @summary Defined type provides an implementation of the hash2properties function, creating a Java properties file from the input hash
#
# @param file Properties of the target file resource.  Accepts and requires the same parameters of a puppet "file"
#  
# @param data Hash representation of the properties file.
#
# @param options Hash of optional values to format output file. See the "hash2properties" function for details.
#
# @example
#   hashfile::properties { 'namevar':
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
define hashfile::properties (
  Hash $file,
  Hash $data,
  Hash $options = {},
) {
  File { $name:
    * => merge($file, content => hash2properties($data, $options)),
  }
}

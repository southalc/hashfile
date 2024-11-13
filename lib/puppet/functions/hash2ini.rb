# @summary Converts a puppet hash to INI file string.
Puppet::Functions.create_function(:hash2ini) do
  # @param input              The hash to be converted to INI file
  # @param options            A hash of options to control INI file format
  # @option header Optional   header to be written at the beginning of the file.  (# THIS FILE IS CONTROLLED BY PUPPET)
  # @option section_prefix    Optional character that indicates the start of a section title. ("[")
  # @option section_suffix    Optional character that indicates the start of a section title. ("]")
  # @option key_val_separator Optional character that indicates separation of key/value pairs. ("=")
  # @option quote_char        Optional character to use to quote INI file values when $use_quotes is 'true'. (")
  # @option use_quotes        Optional boolean to enclose all INI file values in $quote_char. (false)
  # @option quote_booleans    Optional boolean to enclose all INI booleans with $quote_char. (true, but $use_quotes must also be set to true)
  # @option quote_numerics    Optional boolean to enclose all INI numbers with $quote_char. (true, but $use_quotes must also be set to true)
  # @return [String] An INI file formatted string
  # @example Call the function with the $input and $options hashes
  #   hash2ini($input, $options)
  dispatch :ini do
    param 'Hash', :input
    optional_param 'Hash', :options
  end

  def ini(input, options = {})
    settings = {
      'header'            => '# THIS FILE IS CONTROLLED BY PUPPET',
      'section_prefix'    => '[',
      'section_suffix'    => ']',
      'key_val_separator' => '=',
      'quote_char'        => '"',
      'use_quotes'        => true,
      'quote_booleans'    => true,
      'quote_numerics'    => true,
    }

    settings.merge!(options)

    output = []
    output << settings['header'] << nil
    input.each_key do |section|
      output << "#{settings['section_prefix']}#{section}#{settings['section_suffix']}"
      input[section].each do |k, v|
        v_is_a_boolean = (v.is_a?(TrueClass) || v.is_a?(FalseClass))
        if v.is_a?(Array)
          v.each do |dup|
            output << if !settings['use_quotes'] || (dup.is_a?(Numeric) && !settings['quote_numerics'])
                        "#{k}#{settings['key_val_separator']}#{dup}"
                      elsif settings['use_quotes']
                        "#{k}#{settings['key_val_separator']}#{settings['quote_char']}#{dup}#{settings['quote_char']}"
                      else
                        "#{k}#{settings['key_val_separator']}#{dup}"
                      end
          end
        else
          output << if !settings['use_quotes'] || (v_is_a_boolean && !settings['quote_booleans']) || (v.is_a?(Numeric) && !settings['quote_numerics'])
                      "#{k}#{settings['key_val_separator']}#{v}"
                    elsif settings['use_quotes']
                      "#{k}#{settings['key_val_separator']}#{settings['quote_char']}#{v}#{settings['quote_char']}"
                    else
                      "#{k}#{settings['key_val_separator']}#{v}"
                    end
        end
      end
      output << nil
    end
    output.join("\n")
  end
end

require 'command_mapper/command'

module Nikto
  #
  # ## Nikto options:
  #
  # * `-Cgidirs` - `nikto.cgi_dirs`
  # * `-config` - `nikto.config`
  # * `-dbcheck` - `nikto.dbcheck`
  # * `-Display` - `nikto.display`
  # * `-evasion` - `nikto.evasion`
  # * `-findonly` - `nikto.find_only`
  # * `-Format` - `nikto.format`
  # * `-host` - `nikto.host`
  # * `-Help` - `nikto.help`
  # * `-id` - `nikto.id`
  # * `-list-plugins` - `nikto.list_plugins`
  # * `-mutate` - `nikto.mutate`
  # * `-mutate-options` - `nikto.mutate_options`
  # * `-nolookup` - `nikto.no_lookup`
  # * `-nossl` - `nikto.no_ssl`
  # * `-no404` - `nikto.no_404`
  # * `-output` - `nikto.output`
  # * `-plugins` - `nikto.plugins`
  # * `-port` - `nikto.port`
  # * `-Pause` - `nikto.pause`
  # * `-root` - `nikto.root`
  # * `-ssl` - `nikto.ssl`
  # * `-Single` - `nikto.single`
  # * `-timeout` - `nikto.timeout`
  # * `-Tuning` - `nikto.tuning`
  # * `-useproxy` - `nikto.use_proxy`
  # * `-update` - `nikto.update`
  # * `-Version` - `nikto.version`
  # * `-vhost` - `nikto.vhost`
  #
  # @see http://linux.die.net/man/1/nikto
  #
  class Command < CommandMapper::Command

    class OptionString < CommandMapper::Types::List

      #
      # @param [Hash{Symbol => String}] options
      #
      def initialize(options)
        super(type: CommandMapper::Types::Enum.new(options), separator: '')
      end

    end

    class PortList < CommandMapper::Types::Num

      def valdate(value)
        case value
        when Array
          value.each do |element|
            valid, message = validate(element)

            unless valid
              return [valid, message]
            end
          end

          return true
        when Range
          valid, message = super(value.begin)

          unless valid
            return [valid, message]
          end

          valid, message = super(value.end)

          unless valid
            return [valid, message]
          end

          return true
        else
          super(value)
        end
      end

      def format(value)
        case value
        when Array
          value.map(&method(:format)).join(',')
        when Range
          "#{value.begin}-#{value.end}"
        else
          super(value)
        end
      end

    end
    
    command 'nikto' do
      option '-Cgidirs', name: :cgi_dirs, value: true
      option '-config', value: {type: InputFile.new}
      option '-dbcheck'
      option '-Display', value: {
                           type: OptionString.new(
                             :show_redirects => '1',
                             :show_cookies => '2',
                             :show_200_responses => '3',
                             :show_auth_urls => '4',
                             :debug => 'D',
                             :verbose => 'V'
                           )
                         }

      option '-evasion', value: {
                           type: OptionString.new(
                             :random_uri_encoding => '1',
                             :directory_self_reference => '2',
                             :premature_url_ending => '3',
                             :prepend_random_strings => '4',
                             :fake_parameter => '5',
                             :tab_request_spacer => '6',
                             :random_url_case => '7',
                             :windows_directory_separator => '8'
                           )
                         }
      option '-findonly', name: :find_only
      option '-Format', name: :format, value: {
                                         type: Enum[:csv, :htm, :txt, :xml]
                                       }
      option '-host', value: true
      option '-Help', name: :help
      option '-id', value: {type: KeyValue.new(separator: ':')}
      option '-list-plugins'
      option '-mutate', value: {
                          type: OptionString.new(
                            :test_all_files => '1',
                            :enum_password_file_names => '2',
                            :enum_user_dirs => '3',
                            :enum_cgi_users => '4',
                            :bruteforce_subcomdains => '5',
                            :bruteforce_directories => '6'
                          )
                        }
      option '-mutate-options', value: true
      option '-nolookup', name: :no_lookup
      option '-nossl', name: :no_ssl
      option '-no404', name: :no_404
      option '-output', value: true
      option '-plugins', value: {type: List.new}
      option '-port', value: {type: PortList.new}
      option '-Pause', name: :pause, value: {type: Num.new}
      option '-root', value: true
      option '-ssl', value: {type: PortList.new}
      option '-Single', name: :single
      option '-timeout', value: {type: Num.new}
      option '-Tuning', name: :tuning, value: {
                                         type: OptionString.new(
                                           :file_upload => '0',
                                           :interesting_files => '1',
                                           :default_files => '2',
                                           :information_disclosure => '3',
                                           :injection => '4',
                                           :remote_file_retriveal_inside_web_root => '5',
                                           :denail_of_service => '6',
                                           :remote_file_retriveal_server_wide => '7',
                                           :command_execution => '8',
                                           :sql_injection => '9',
                                           :authentication_bypass => 'a',
                                           :software_identification => 'b',
                                           :remote_source_inclusion => 'c',
                                           :reverse_tuning_options => 'x'
                                         )
                                       }
      option '-useproxy', name: :use_proxy
      option '-update'
      option '-Version', name: :version
      option '-vhost'
    end

  end
end

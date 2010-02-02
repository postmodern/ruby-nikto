require 'rprogram/task'

module Nikto
  #
  # ## Nikto options:
  #
  # * `-h` - `nikto.host`
  # * `-config` - `nikto.config`
  # * `-Cgidirs` - `nikto.cgi_dirs`
  # * `-cookies` - `nikto.print_cookies`
  # * `-evasion` - `nikto.evasion`
  # * `-findonly` - `nikto.evasion`
  # * `-Format` - `nikto.format`
  # * `-generic` - `nikto.full_scan`
  # * `-id` - `nikto.http_auth`
  # * `-mutate` - `nikto.mutate_checks`
  # * `-nolookup` - `nikto.no_lookup`
  # * `-output` - `nikto.output`
  # * `-port` - `nikto.port`
  # * `-root` - `nikto.root`
  # * `-ssl` - `nikto.ssl`
  # * `-timeout` - `nikto.timeout`
  # * `-useproxy` - `nikto.enable_proxy`
  # * `-vhost` - `nikto.vhost`
  # * `-Version` - `nikto.version`
  # * `-404` - `nikto.not_found_message`
  # * `-dbcheck` - `nikto.validate_checks`
  # * `-debug` - `nikto.debug`
  # * `-update` - `nikto.update`
  # * `-verbose` - `nikto.verbose`
  #
  # @see http://linux.die.net/man/1/nikto
  #
  class Task < RProgram::Task

    short_option :flag => '-h', :name => :host
    short_option :flag => '-config', :name => :config
    short_option :flag => '-Cgidirs', :name => :cgi_dirs
    short_option :flag => '-cookies', :name => :print_cookies
    short_option :flag => '-evasion', :name => :evasion

    #
    # Enable random URI encoding.
    #
    def random_uri_encoding!
      self.evasion ||= ''
      self.evasion << '1'
    end

    #
    # Enable adding self-referencing directories (`/./`) to the
    # request.
    #
    def directory_self_reference!
      self.evasion ||= ''
      self.evasion << '2'
    end

    #
    # Enable premature URL ending.
    #
    def premature_url_ending!
      self.evasion ||= ''
      self.evasion << '3'
    end

    #
    # Enable prepend long random strings to the request.
    #
    def prepend_random_strings!
      self.evasion ||= ''
      self.evasion << '4'
    end

    #
    # Enable fake parameters to files.
    #
    def fake_params_to_files!
      self.evasion ||= ''
      self.evasion << '5'
    end

    #
    # Enable using a tab character as the request spacer, instead of
    # spaces.
    #
    def tab_request_spacer!
      self.evasion ||= ''
      self.evasion << '6'
    end

    #
    # Enable random case sensitivity.
    #
    def random_casing!
      self.evasion ||= ''
      self.evasion << '7'
    end

    #
    # Enable use of Windows style directory separators
    # (<code>\\</code> instead of <code>/</code>).
    #
    def windows_directories!
      self.evasion ||= ''
      self.evasion << '8'
    end

    #
    # Enable session splicing.
    #
    def session_splicing!
      self.evasion ||= ''
      self.evasion << '9'
    end

    short_option :flag => '-findonly', :name => :only_find
    short_option :flag => '-Format', :name => :format

    #
    # Sets the report format to `HTM`.
    #
    def html_format!
      self.format = 'HTM'
    end

    #
    # Sets the report format to `TXT`.
    #
    def text_format!
      self.format = 'TXT'
    end

    #
    # Sets the report format to `CVS`.
    #
    def csv_format!
      self.format = 'CSV'
    end

    short_option :flag => '-generic', :name => :full_scan
    short_option :flag => '-id', :name => :http_auth
    short_option :flag => '-mutate', :name => :mutate_checks
    short_option :flag => '-nolookup', :name => :no_lookup
    short_option :flag => '-output', :name => :output
    short_option :flag => '-port', :name => :port
    short_option :flag => '-root', :name => :root
    short_option :flag => '-ssl', :name => :ssl
    short_option :flag => '-timeout', :name => :timeout
    short_option :flag => '-useproxy', :name => :enable_proxy
    short_option :flag => '-vhost', :name => :vhost
    short_option :flag => '-Version', :name => :version

    short_option :flag => '-404', :name => :not_found_message
    short_option :flag => '-dbcheck', :name => :validate_checks
    short_option :flag => '-debug', :name => :debug
    short_option :flag => '-update', :name => :update
    short_option :flag => '-verbose', :name => :verbose

  end
end

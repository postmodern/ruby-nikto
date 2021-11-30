require 'nikto/xml/scan_details'

require 'nokogiri'

module Nikto
  #
  # Represents an nikto XML file or XML data.
  #
  class XML

    # The parsed XML document.
    #
    # @return [Nokogiri::XML]
    #
    # @api private
    attr_reader :doc

    # The path to the XML file.
    #
    # @return [String, nil]
    attr_reader :path

    #
    # Creates a new XML object.
    #
    # @param [Nokogiri::XML] doc
    #   The parsed XML document.
    #
    # @param [String, nil] path
    #   The path to the XML file.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the newly created XML
    #   parser.
    #
    # @yieldparam [XML] xml
    #   The newly created XML parser.
    #
    # @api private
    #
    def initialize(doc, path: nil)
      @doc  = doc
      @path = File.expand_path(path) if path

      yield self if block_given?
    end

    #
    # Parses the given XML String.
    #
    # @param [String] xml
    #   The XML String.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the newly created XML
    #   parser.
    #
    # @yieldparam [XML] xml
    #   The newly created XML parser.
    #
    # @return [XML]
    #   The parsed XML.
    #
    # @api public
    #
    def self.parse(xml,&block)
      new(Nokogiri::XML(xml),&block)
    end

    #
    # Opens an parses an XML file.
    #
    # @param [String] path
    #   The path to the XML file.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the newly created XML
    #   parser.
    #
    # @yieldparam [XML] xml
    #   The newly created XML parser.
    #
    # @return [XML]
    #   The parsed XML.
    #
    # @api public
    #
    def self.open(path,&block)
      path = File.expand_path(path)

      new(Nokogiri::XML(File.open(path)), path: path, &block)
    end

    #
    # The `hoststest` value.
    #
    # @return [Integer]
    #   The parsed value of the `hoststest` attribute.
    #
    def hosts_test
      @hosts_test ||= @doc.root['@hoststest'].to_i
    end

    #
    # Additional command-line options passed to `nikto`.
    #
    # @return [String]
    #   The value of the `options` attribute.
    #
    def options
      @doc.root['options']
    end

    #
    # When the scan started.
    #
    # @return [Time]
    #   The parsed value of the `scanstart` attribute.
    #
    def scan_start
      @scan_start ||= Time.parse(@doc.root['scanstart'])
    end

    #
    # When the scan completed.
    #
    # @return [Time]
    #   The parsed value `scanned` attribute.
    #
    def scan_end
      @scan_end ||= Time.parse(@doc.root['scanend'])
    end

    #
    # The duration of the scan.
    #
    # @return [String]
    #   The value of the `scanelapsed` attribute.
    #
    def scan_elapsed
      @doc.root['scanelapsed']
    end

    #
    # The Nikto XML schema version.
    #
    # @return [String]
    #   The value of the `nxmlversion` attribute.
    #
    def nikto_xml_version
      @doc.root['nxmlversion']
    end

    #
    # Parses each `scandetails` child element.
    #
    # @yield [scan_details]
    #   If a block is given, it will be yielded each scan details object.
    #
    # @yieldparam [ScanDetails] scan_details
    #   A scan details object.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator will be returned.
    #
    def each_scan_details
      return enum_for(__method__) unless block_given?

      @doc.xpath('/niktoscan/scandetails').each do |node|
        yield ScanDetails.new(node)
      end
    end

    #
    # The scan details.
    #
    # @return [Array<ScanDetails>]
    #
    def scan_details
      each_scan_details.to_a
    end

    alias each_target each_scan_details

    alias targets scan_details

    #
    # The first scan details object.
    #
    # @return [ScanDetails, nil]
    #
    def target
      each_target.first
    end

    #
    # Converts the XML object to a String.
    #
    # @return [String]
    #   The path to the XML if {#path} is set, or the XML if the XML was parsed
    #   from a String.
    #
    def to_s
      if @path
        @path
      else
        @doc.to_s
      end
    end

  end
end

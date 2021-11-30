require 'nikto/xml/scan_details'

require 'nokogiri'

module Nikto
  class XML

    # The parsed XML document.
    #
    # @return [Nokogiri::XML]
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
    # @return [XML]
    #   The parsed XML.
    #
    def self.parse(xml)
      new(Nokogiri::XML(xml))
    end

    #
    # Opens an parses an XML file.
    #
    # @param [String] path
    #   The path to the XML file.
    #
    # @return [XML]
    #   The parsed XML.
    #
    def self.open(path)
      path = File.expand_path(path)

      new(Nokogiri::XML(File.open(path)), path: path)
    end

    #
    # @return [Integer]
    #
    def hosts_test
      @hosts_test ||= @doc.root['@hoststest'].to_i
    end

    #
    # Additional command-line options passed to `nikto`.
    #
    # @return [String]
    #
    def options
      @doc.root['options']
    end

    #
    # When the scan started.
    #
    # @return [Time]
    #
    def scan_start
      @scan_start ||= Time.parse(@doc.root['scanstart'])
    end

    #
    # When the scan completed.
    #
    # @return [Time]
    #
    def scan_end
      @scan_end ||= Time.parse(@doc.root['scanend'])
    end

    #
    # The duration of the scan.
    #
    # @return [String]
    #
    def scan_elapsed
      @doc.root['scanelapsed']
    end

    #
    # The Nikto XML schema version.
    #
    # @return [String]
    #
    def nikto_xml_version
      @doc.root['nxmlversion']
    end

    #
    # @yield [scan_details]
    #
    # @yieldparam [ScanDetails] scan_details
    #
    # @return [Enumerator]
    #
    def each_scan_details
      return enum_for(__method__) unless block_given?

      @doc.xpath('/niktoscan/scandetails').each do |node|
        yield ScanDetails.new(node)
      end
    end

    #
    # @return [Array<ScanDetails>]
    #
    def scan_details
      each_scan_details.to_a
    end

    alias each_target each_scan_details

    alias targets scan_details

    #
    # @return [ScanDetails, nil]
    #
    def target
      each_target.first
    end

    #
    # @return [String]
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

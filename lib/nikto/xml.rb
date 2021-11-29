require 'nokogiri'

module Nikto
  class XML

    # The path to the XML file.
    #
    # @return [String, nil]
    attr_reader :path

    # The parsed XML document.
    attr_reader :doc

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
      @path = File.expand_path(path) if path
      @doc  = doc

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

  end
end

require 'nokogiri'

module Nikto
  class XML

    #
    # Creates a new XML object.
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
    def initialize(path)
      @path = File.expand_path(path)
      @xml  = Nokogiri::XML(File.new(@path))

      yield self if block_given?
    end

    #
    # Converts the XML object into a String.
    #
    # @return [String]
    #   The path to the nikto XML file.
    #
    def to_s
      @path.to_s
    end

  end
end

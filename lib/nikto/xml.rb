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
    def initialize(path,&block)
      @path = File.expand_path(path)
      @xml = Nokogiri::XML(File.new(@path))

      block.call(self) if block
    end

    def to_s
      @path.to_s
    end

  end
end

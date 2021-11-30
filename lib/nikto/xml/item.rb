module Nikto
  class XML
    class Item

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [String]
      #
      def description
        @description ||= @node.at_xpath('description').inner_text
      end

      #
      # @return [String]
      #
      def uri
        @uri ||= @node.at_xpath('uri').inner_text
      end

      #
      # @return [String]
      #
      def name_link
        @name_link ||= @node.at_xpath('namelink').inner_text
      end

      #
      # @return [String]
      #
      def ip_link
        @ip_link ||= @node.at_xpath('iplink').inner_text
      end

    end
  end
end

module Nikto
  class XML
    class Item

      #
      # Initializes the item object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `item` XML element.
      #
      # @api private
      #
      def initialize(node)
        @node = node
      end

      #
      # The text of the `description` child element.
      #
      # @return [String]
      #
      def description
        @description ||= @node.at_xpath('description').inner_text
      end

      #
      # The text of the `uri` child element.
      #
      # @return [String]
      #
      def uri
        @uri ||= @node.at_xpath('uri').inner_text
      end

      #
      # The text of the `namelink` child element.
      #
      # @return [String]
      #
      def name_link
        @name_link ||= @node.at_xpath('namelink').inner_text
      end

      #
      # The text of the `iplink` child element.
      #
      # @return [String]
      #
      def ip_link
        @ip_link ||= @node.at_xpath('iplink').inner_text
      end

    end
  end
end

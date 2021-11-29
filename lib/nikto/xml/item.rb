module Nikto
  class XML
    class Item

      def initialize(node)
        @node = node
      end

      def description
        @description ||= @node.xpath('description').inner_text
      end

      def uri
        @uri ||= @node.xpath('uri').inner_text
      end

      def name_link
        @name_link ||= @node.xpath('namelink').inner_text
      end

      def ip_link
        @ip_link ||= @node.xpath('iplink').inner_text
      end

    end
  end
end

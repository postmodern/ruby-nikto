require 'time'

module Nikto
  class XML
    #
    # Represents a `statistics` XML element.
    #
    class Statistics

      #
      # Initializes the statistics object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `statistics` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The number of seconds elapsed.
      #
      # @return [Intger]
      #   The parsed value of the `elapsed` attribute.
      #
      def elapsed
        @elapsed ||= @node['elapsed'].to_i
      end

      #
      # The number of items found.
      #
      # @return [Intger]
      #   The parsed value of the `itemsfound` attribute.
      #
      def items_found
        @items_found ||= @node['itemsfound'].to_i
      end

      #
      # The number of items tested.
      #
      # @return [Intger]
      #   The parsed value of the `itemstested` attribute.
      #
      def items_tested
        @items_tested ||= @node['itemstested'].to_i
      end

      #
      # The end-time of the scan.
      #
      # @return [Time]
      #   The parsed value of the `endtime` attribute.
      #
      def end_time
        @end_time ||= Time.parse(@node['endtime'])
      end

    end
  end
end

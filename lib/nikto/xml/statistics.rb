require 'time'

module Nikto
  class XML
    class Statistics

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [Intger]
      #
      def elapsed
        @elapsed ||= @node['elapsed'].to_i
      end

      #
      # @return [Intger]
      #
      def items_found
        @items_found ||= @node['itemsfound'].to_i
      end

      #
      # @return [Intger]
      #
      def items_tested
        @items_tested ||= @node['itemstested'].to_i
      end

      #
      # @return [Time]
      #
      def end_time
        @end_time ||= Time.parse(@node['endtime'])
      end

    end
  end
end

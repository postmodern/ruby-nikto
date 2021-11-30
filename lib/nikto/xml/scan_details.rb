require 'nikto/xml/item'
require 'nikto/xml/statistics'

require 'time'

module Nikto
  class XML
    class ScanDetails

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [String]
      #
      def target_ip
        @node['targetip']
      end

      #
      # @return [String]
      #
      def target_hostname
        @node['targethostname']
      end

      #
      # @return [Integer]
      #
      def target_port
        @target_port ||= @node['targetport'].to_i
      end

      #
      # @return [String]
      #
      def target_banner
        @node['targetbanner']
      end

      #
      # @return [Time]
      #
      def start_time
        @start_time ||= Time.parse(@node['starttime'])
      end

      #
      # @return [String]
      #
      def site_name
        @node['sitename']
      end

      #
      # @return [String]
      #
      def site_ip
        @node['siteip']
      end

      #
      # @return [String]
      #
      def host_header
        @node['hostheader']
      end

      #
      # @return [Integer]
      #
      def errors
        @errors ||= @node['errors'].to_i
      end

      def errors?
        errors > 0
      end

      #
      # @return [Integer]
      #
      def checks
        @checks ||= @node['checks'].to_i
      end

      #
      # @yield [item]
      #
      # @yieldparam [Item] item
      #
      # @return [Enumerator]
      #
      def each_item
        return enum_for(__method__) unless block_given?

        @node.xpath('item').each do |node|
          yield Item.new(node)
        end
      end

      #
      # @return [Array<Item>]
      #
      def items
        each_item.to_a
      end

      #
      # @return [Statistics]
      #
      def statistics
        @statistics ||= Statistics.new(@node.at_xpath('statistics'))
      end

    end
  end
end

require 'nikto/xml/item'
require 'nikto/xml/statistics'

require 'time'

module Nikto
  class XML
    #
    # Represents a `scandetails` XML element.
    #
    class ScanDetails

      #
      # Initializes the scan details object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `scandetails` XML element.
      #
      # @api private
      #
      def initialize(node)
        @node = node
      end

      #
      # The target's IP address.
      #
      # @return [String]
      #   The value of the `targetip` attribute.
      #
      def target_ip
        @node['targetip']
      end

      #
      # The target's hostname.
      #
      # @return [String]
      #   The value of the `targethostname` attribute.
      #
      def target_hostname
        @node['targethostname']
      end

      #
      # The target's port number.
      #
      # @return [Integer]
      #   The parsed value of the `targetport` attribute.
      #
      def target_port
        @target_port ||= @node['targetport'].to_i
      end

      #
      # The target's banner value.
      #
      # @return [String]
      #   The value of the `targetbanner` attribute.
      #
      def target_banner
        @node['targetbanner']
      end

      #
      # When the target started being scanned.
      #
      # @return [Time]
      #   The parsed value `starttime` attribute.
      #
      def start_time
        @start_time ||= Time.parse(@node['starttime'])
      end

      #
      # The site name.
      #
      # @return [String]
      #   The value of the `sitename` attribute.
      #
      def site_name
        @node['sitename']
      end

      #
      # The site's IP address.
      #
      # @return [String]
      #   The value of the `siteip` attribute.
      #
      def site_ip
        @node['siteip']
      end

      #
      # The `Host` header.
      #
      # @return [String]
      #   The value of the `hostheader` attribute.
      #
      def host_header
        @node['hostheader']
      end

      #
      # How many errors occurred.
      #
      # @return [Integer]
      #   The parsed value of the `errors` attribute.
      #
      def errors
        @errors ||= @node['errors'].to_i
      end

      #
      # Determines if any errors occurred.
      #
      # @return [Boolean]
      #
      def errors?
        errors > 0
      end

      #
      # How many checks were performed on the target.
      #
      # @return [Integer]
      #   The parsed value of the `checks` attribute.
      #
      def checks
        @checks ||= @node['checks'].to_i
      end

      #
      # Enumerates over the found items.
      #
      # @yield [item]
      #   If a block is given, it will be passed each item object.
      #
      # @yieldparam [Item] item
      #   An item object.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator object will be returned.
      #
      def each_item
        return enum_for(__method__) unless block_given?

        @node.xpath('item').each do |node|
          yield Item.new(node)
        end
      end

      #
      # The found items for the target.
      #
      # @return [Array<Item>]
      #
      def items
        each_item.to_a
      end

      #
      # The statistics associated with the scan.
      #
      # @return [Statistics]
      #   Represents the `statistics` XML element.
      #
      def statistics
        @statistics ||= Statistics.new(@node.at_xpath('statistics'))
      end

    end
  end
end

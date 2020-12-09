# frozen_string_literal: true

module Facter
  module Resolvers
    class NetworkingLinux < BaseResolver
      init_resolver

      DIRS = ['/var/lib/dhclient/', '/var/lib/dhcp/', '/var/lib/dhcp3/', '/var/lib/NetworkManager/', '/var/db/'].freeze

      ROUTE_TYPES = %w[anycast
                       unicast
                       broadcast
                       local
                       nat
                       unreachable
                       prohibit
                       blackhole
                       throw].freeze
      class << self
        private

        def post_resolve(fact_name)
          @fact_list.fetch(fact_name) { read_routing_table(fact_name) }

          @fact_list[fact_name]
        end

        def read_routing_table(_fact_name)
          ipv4_output = Facter::Core::Execution.execute('ip route show', logger: log)
          ipv6_output = Facter::Core::Execution.execute('ip -6 route show', logger: log)
          routes4 = parse_routes(ipv4_output, 'ipv4')
          routes6 = parse_routes(ipv6_output, 'ipv6')
          puts routes6
          puts routes4
          {}
        end

        def parse_routes(output, family)
          routes = []
          output.each_line do |line|
            parts = line.split(' ').compact
            next if parts.include?('linkdown')

            route_type = parts[0]
            parts.delete_at(0) if ROUTE_TYPES.include?(route_type)
            next if family == 'ipv6' && !parts[0].include?(':')

            route = construct_route(parts)
            routes << route
          end
          routes
        end

        def construct_route(parts)
          route = {}
          route[:destination] = parts[0]
          dev_index = parts.find_index { |elem| elem == 'dev' }
          src_index = parts.find_index { |elem| elem == 'src' }
          route[:interface] = parts[dev_index + 1] if dev_index
          route[:source] = parts[src_index + 1] if src_index
          route
        end
      end
    end
  end
end

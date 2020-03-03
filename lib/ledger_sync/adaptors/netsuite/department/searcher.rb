# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        class Searcher < Searcher
          def resources
            @resources ||= begin
              @request = adaptor
                .get(
                  path: "/department?limit=#{limit}&offset=#{offset}"
                )

              request.body
                .fetch('items')
                .map do |c|
                  LedgerSerializer.new(
                    resource: LedgerSync::Department.new
                  ).deserialize(hash: c)
                end
            end
          end
        end
      end
    end
  end
end

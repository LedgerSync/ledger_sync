# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class Searcher < Searcher
          def resources
            @resources ||= begin
              @request = adaptor
                .get(
                  path: "/account?limit=#{limit}&offset=#{offset}"
                )

              request.body
                .fetch('items')
                .map do |c|
                  LedgerDeserializer.new(
                    resource: LedgerSync::Account.new
                  ).deserialize(hash: c)
                end
            end
          end
        end
      end
    end
  end
end

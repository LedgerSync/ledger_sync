# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerEntityType < LedgerSync::Type::Value
          private

          def cast_value(args = {})
            value = args.fetch(:value)

            unless value.nil?
              resource = (value.fetch("links").first.fetch("href").include? "vendor") ? Vendor : Customer
              resource.new(
                ledger_id: value['id']
              )
            end
          end

          def valid_classes
            [
              Hash
            ]
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../journal_entry_line_item/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        class Serializer < NetSuite::Serializer
          attribute :memo

          attribute :trandate

          attribute :tranId

          references_one :currency,
                         serializer: Reference::Serializer, if: :currency_present?

          references_one :subsidiary,
                         serializer: Reference::Serializer

          references_many 'line.items',
                          resource_attribute: :line_items,
                          serializer: JournalEntryLineItem::Serializer

          def currency_present?(args = {})
            resource = args.fetch(:resource)

            resource.currency.present?
          end
        end
      end
    end
  end
end

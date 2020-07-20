# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineDetail
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :Account,
                         hash_attribute: 'AccountRef',
                         deserializer: Reference::Deserializer

          references_one :Class,
                         hash_attribute: 'ClassRef',
                         deserializer: Reference::Deserializer

          attribute(:Entity) do |args = {}|
            hash = args.fetch(:hash)
            value = hash.fetch('Entity', nil)

            unless value.nil?
              Client.ledger_resource_for(
                type: value['type']
              ).new(
                ledger_id: value['value']
              )
            end
          end
        end
      end
    end
  end
end

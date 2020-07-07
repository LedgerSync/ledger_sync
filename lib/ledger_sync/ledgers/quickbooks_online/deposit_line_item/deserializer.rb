# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :account,
                         hash_attribute: 'DepositLineDetail.AccountRef',
                         deserializer: Reference::Deserializer

          references_one :ledger_class,
                         hash_attribute: 'DepositLineDetail.ClassRef',
                         deserializer: Reference::Deserializer

          attribute(:entity) do |args = {}|
            hash = args.fetch(:hash)
            value = hash.fetch('DepositLineDetail.Entity', nil)

            unless value.nil?
              Client.ledger_resource_for(
                type: value['type']
              ).new(
                ledger_id: value['value']
              )
            end
          end

          amount :amount,
                 hash_attribute: 'Amount'

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end

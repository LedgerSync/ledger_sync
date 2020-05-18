# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute 'account.ledger_id',
                    hash_attribute: 'DepositLineDetail.AccountRef.value'

          attribute 'ledger_class.ledger_id',
                    hash_attribute: 'DepositLineDetail.ClassRef.value'

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

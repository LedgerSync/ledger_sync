# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute('DetailType') { 'DepositLineDetail' }

          attribute 'DepositLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'DepositLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute('DepositLineDetail.Entity') do |args = {}|
            resource = args.fetch(:resource)

            if resource.entity.present?
              {
                'name' => resource.entity.name,
                'value' => resource.entity.ledger_id,
                'type' => Client.ledger_resource_type_for(
                  resource_class: resource.entity.class
                ).classify
              }
            end
          end

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end

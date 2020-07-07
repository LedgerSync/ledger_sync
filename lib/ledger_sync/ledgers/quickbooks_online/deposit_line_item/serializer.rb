# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute('DetailType') { 'DepositLineDetail' }

          references_one 'DepositLineDetail.AccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'DepositLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         serializer: Reference::Serializer

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

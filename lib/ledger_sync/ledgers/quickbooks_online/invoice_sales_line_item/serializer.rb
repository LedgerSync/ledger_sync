# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceSalesLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'DetailType' do
            'SalesItemLineDetail'
          end

          references_one 'SalesItemLineDetail.ItemRef',
                         resource_attribute: :item,
                         serializer: Reference::Serializer

          references_one 'SalesItemLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         serializer: Reference::Serializer

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end

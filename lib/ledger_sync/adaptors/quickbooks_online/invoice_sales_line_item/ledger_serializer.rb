# frozen_string_literal: true

require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module InvoiceSalesLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DetailType' do
            'SalesItemLineDetail'
          end

          references_one ledger_attribute: 'SalesItemLineDetail.ItemRef',
                         resource_attribute: :item,
                         resource_class: LedgerSync::Item,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'SalesItemLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         resource_class: LedgerSync::LedgerClass,
                         serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end

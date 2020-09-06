# frozen_string_literal: true

require_relative '../sales_item_line_detail/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceLine
        class Serializer < QuickBooksOnline::Serializer
          id
          amount :Amount
          attribute :Description

          attribute :DetailType do
            'SalesItemLineDetail'
          end

          references_one 'SalesItemLineDetail',
                         resource_attribute: :SalesItemLineDetail,
                         serializer: SalesItemLineDetail::Serializer
        end
      end
    end
  end
end

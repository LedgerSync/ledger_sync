# frozen_string_literal: true

require_relative '../sales_item_line_detail/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceLine
        class Deserializer < QuickBooksOnline::Deserializer
          id
          amount :Amount
          attribute :Description

          references_one :SalesItemLineDetail,
                         hash_attribute: 'SalesItemLineDetail',
                         deserializer: SalesItemLineDetail::Deserializer
        end
      end
    end
  end
end

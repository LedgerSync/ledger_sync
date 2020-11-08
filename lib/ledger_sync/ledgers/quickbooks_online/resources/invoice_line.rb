# frozen_string_literal: true

require_relative 'sales_item_line_detail'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceLine < QuickBooksOnline::Resource
        references_one :SalesItemLineDetail, to: SalesItemLineDetail
        attribute :Amount, type: Type::Integer
        attribute :Description, type: Type::String

        def name
          self.Description
        end
      end
    end
  end
end

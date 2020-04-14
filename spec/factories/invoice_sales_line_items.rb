# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_sales_line_item, class: LedgerSync::InvoiceSalesLineItem do
    references_one :item
    references_one :ledger_class

    amount { 12_345 }
    sequence(:description) { |n| "Test Line Item #{rand_id(n)}" }
    quantity { 1.0 }
  end
end

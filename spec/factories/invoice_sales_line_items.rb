# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_sales_line_item, class: LedgerSync::InvoiceSalesLineItem do
    sequence(:external_id) { |n| "inv-sales-line-item-#{rand_id(n)}" }
    sequence(:description) { |n| "Test Invoice Sales Line Item #{rand_id}-#{n}" }

    item { FactoryBot.create(:item) }
    ledger_class { FactoryBot.create(:ledger_class) }

    amount { 100 }
  end
end

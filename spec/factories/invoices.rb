# frozen_string_literal: true

FactoryBot.define do
  factory :invoice, class: LedgerSync::Bundles::ModernTreasury::Invoice do
    sequence(:external_id) { |n| "inv-#{rand_id(n)}" }

    sequence(:memo) { |n| "Test Invoice #{rand_id}-#{n}" }
    transaction_date { Date.today }
    deposit { 100 }

    account { FactoryBot.create(:account) }
    currency { FactoryBot.create(:currency) }
    customer { FactoryBot.create(:customer) }

    line_items { FactoryBot.create_list(:invoice_sales_line_item, 2) }
  end
end

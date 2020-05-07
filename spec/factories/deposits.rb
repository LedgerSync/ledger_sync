# frozen_string_literal: true

FactoryBot.define do
  factory :deposit, class: LedgerSync::Deposit do
    sequence(:memo) { |n| "Test Deposit #{rand_id}-#{n}" }
    transaction_date { Date.today }
    exchange_rate { 1.5 }
    account { FactoryBot.create(:account) }
    currency { FactoryBot.create(:currency) }
    department { FactoryBot.create(:department) }
    sequence(:external_id) { |n| "dep-#{rand_id(n)}" }
    line_items { FactoryBot.create_list(:deposit_line_item, 2) }
  end
end

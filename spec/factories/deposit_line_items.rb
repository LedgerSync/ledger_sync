# frozen_string_literal: true

FactoryBot.define do
  factory :deposit_line_item, class: LedgerSync::DepositLineItem do
    account { FactoryBot.create(:account) }
    ledger_class { FactoryBot.create(:ledger_class) }
    entity { FactoryBot.create(:customer) }
    sequence(:external_id) { |n| "dep-line-item-#{rand_id(n)}" }
    amount { 100 }
    sequence(:description) { |n| "Test Deposit Line Item #{rand_id}-#{n}" }
  end
end

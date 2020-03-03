# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: LedgerSync::Account do
    sequence(:name) { |n| "Test Account #{rand_id}-#{n}" }
    sequence(:number) { |n| (1000 + n).to_s }
    classification { 'asset' }
    account_type { 'bank' }
    account_sub_type { 'cash_on_hand' }
    currency { FactoryBot.create(:currency) }
    description { "Test #{rand_id} Account description" }
    sequence(:external_id) { |n| "acct-#{rand_id(n)}" }
    active { true }
  end
end

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
    active { true }

    trait :without_test_run_id do
      description { 'This is Sample Account' }
      name { 'Sample Account' }
      currency { FactoryBot.create(:currency, :without_test_run_id) }
    end
  end
end

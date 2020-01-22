# frozen_string_literal: true

FactoryBot.define do
  factory :bill, class: LedgerSync::Bill do
    references_one :account

    sequence(:memo) { |n| "Memo #{n}" }
    currency { FactoryBot.create(:currency) }

    trait :without_test_run_id do
      currency { FactoryBot.create(:currency, :without_test_run_id) }
    end
  end
end

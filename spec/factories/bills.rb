# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: LedgerSync::Account do
    sequence(:name) { |n| "Test Account #{n}" }
  end

  factory :bill, class: LedgerSync::Bill do
    references_one :account

    sequence(:memo) { |n| "Memo #{n}" }
  end
end

# # frozen_string_literal: true

FactoryBot.define do
  factory :account, class: LedgerSync::Account do
    sequence(:name) { |n| "Test Account #{n}" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :ledger_class, class: LedgerSync::LedgerClass do
    sequence(:name) { |n| "Test Class #{rand_id(n)}" }
    sequence(:fully_qualified_name) { |n| "Test Full Class #{rand_id(n)}" }
    active { true }
    sub_class { nil }
  end
end

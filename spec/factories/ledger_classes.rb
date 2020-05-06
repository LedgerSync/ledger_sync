# frozen_string_literal: true

FactoryBot.define do
  factory :ledger_class, class: LedgerSync::LedgerClass do
    sequence(:external_id) { |n| "ledger_class_#{rand_id(n)}" }
    sequence(:name) { |n| "Test Ledger Class #{rand_id(n)}" }
  end
end

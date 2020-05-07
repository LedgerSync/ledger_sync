# frozen_string_literal: true

FactoryBot.define do
  factory :ledger_class, class: LedgerSync::LedgerClass do
    sequence(:external_id) { |n| "ledger_class-#{rand_id(n)}" }
    sequence(:name) { |n| "Ledger Class #{rand_id}-#{n}" }
    sequence(:fully_qualified_name) { |n| "Ledger Class FQN #{rand_id}-#{n}" }
    active { true }
    sub_class { nil }
    parent { nil }
  end
end

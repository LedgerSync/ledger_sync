# frozen_string_literal: true

FactoryBot.define do
  factory :bill_line_item, class: LedgerSync::BillLineItem do
    references_one :account

    amount { 12_345 }
    sequence(:description) { |n| "Test Line Item #{rand_id(n)}" }

    trait :without_test_run_id do
      sequence(:description) { |n| "Test Line Item #{n}" }
    end
  end
end

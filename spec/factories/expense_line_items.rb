# frozen_string_literal: true

FactoryBot.define do
  factory :expense_line_item, class: LedgerSync::Bundles::ModernTreasury::ExpenseLineItem do
    references_one :account

    amount { 12_345 }
    sequence(:description) { |n| "Test Line Item #{rand_id(n)}" }
  end
end

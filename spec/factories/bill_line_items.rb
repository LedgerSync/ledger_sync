# frozen_string_literal: true

FactoryBot.define do
  factory :bill_line_item, class: LedgerSync::Bundles::ModernTreasury::BillLineItem do
    references_one :account

    amount { 100 }
    sequence(:description) { |n| "Test Line Item #{rand_id(n)}" }
  end
end

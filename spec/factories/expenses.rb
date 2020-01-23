# frozen_string_literal: true

FactoryBot.define do
  factory :expense, class: LedgerSync::Expense do
    references_one :entity, factory: :vendor
    references_one :account
    references_one :currency

    references_many :line_items,
                    count: 2,
                    factory: :expense_line_item

    sequence(:memo) { |n| "Testing #{rand_id(n)}" }
    payment_type { 'cash' }
    transaction_date { Date.today }
    exchange_rate { 1.0 }
  end
end

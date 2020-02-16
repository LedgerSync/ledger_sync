# frozen_string_literal: true

FactoryBot.define do
  factory :bill_payment, class: LedgerSync::BillPayment do
    references_one :account
    references_one :currency
    references_one :department
    references_one :vendor

    references_many :line_items,
                    count: 1,
                    factory: :bill_payment_line_item

    amount { 100 }
    sequence(:memo) { |n| "Testing #{rand_id(n)}" }
    transaction_date { Date.today }
    payment_type { 'credit_card' }
    exchange_rate { 1.0 }
    sequence(:reference_number) { |n| "Ref #{rand_id(n)}" }
  end
end

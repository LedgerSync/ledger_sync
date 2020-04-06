 # frozen_string_literal: true

FactoryBot.define do
  factory :invoice, class: LedgerSync::Invoice do
    references_one :customer
    references_one :account
    references_one :currency

    references_many :line_items,
                    count: 2,
                    factory: :invoice_sales_line_item

    sequence(:memo) { |n| "Testing #{rand_id(n)}" }
    transaction_date { Date.today }
    deposit { 123 }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :bill, class: LedgerSync::Bill do
    references_one :account
    references_one :currency
    references_one :vendor

    sequence(:memo) { |n| "Memo #{n}" }
  end
end

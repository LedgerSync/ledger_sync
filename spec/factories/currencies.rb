# frozen_string_literal: true

FactoryBot.define do
  factory :currency, class: LedgerSync::Bundles::ModernTreasury::Currency do
    exchange_rate { 1.5 }
    sequence(:external_id) { |n| "currency_#{rand_id(n)}" }
    sequence(:name) { |n| "Test Currency #{rand_id}-#{n}" }
    symbol { 'ZZZ' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: LedgerSync::Item do
    sequence(:name) { |n| "Test Item #{rand_id(n)}" }
  end
end

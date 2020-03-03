# frozen_string_literal: true

FactoryBot.define do
  factory :department, class: LedgerSync::Department do
    sequence(:name) { |n| "Test Department #{rand_id(n)}" }
    sequence(:fully_qualified_name) { |n| "Test Department #{rand_id(n)}" }
  end
end

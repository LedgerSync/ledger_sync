# frozen_string_literal: true

FactoryBot.define do
  factory :customer, class: LedgerSync::Customer do
    sequence(:email) { |n| "test_customer_#{rand_id}-#{n}@example.com" }
    sequence(:name) { |n| "Test Customer #{rand_id}-#{n}" }
    phone_number { '+14155555555' }
  end
end

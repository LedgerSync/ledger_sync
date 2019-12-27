# frozen_string_literal: true

FactoryBot.define do
  factory :vendor, class: LedgerSync::Vendor do
    references_one :subsidiary

    sequence(:company_name) { |n| "Test Company #{rand_id(n)}" }
    sequence(:email) { |n| "test-#{rand_id(n)}-vendor@example.com" }
    sequence(:first_name) { |n| "TestFirst#{rand_id(n)}" }
    sequence(:last_name) { |n| "TestLast#{rand_id(n)}" }
    sequence(:display_name) { |n| "Test #{rand_id(n)} Display Name" }
  end
end

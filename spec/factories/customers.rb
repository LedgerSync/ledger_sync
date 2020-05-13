# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    factory :bundle_customer, class: LedgerSync::Bundles::ModernTreasury::Customer do
      sequence(:external_id) { |n| "customer_#{rand_id(n)}" }
      sequence(:email) { |n| "test_customer_#{rand_id(n)}@example.com" }
      sequence(:name) { |n| "Test Customer #{rand_id(n)}" }
      phone_number { '+14155555555' }
    end

    factory :netsuite_customer, class: LedgerSync::Ledgers::NetSuite::Customer do
      sequence(:external_id) { |n| "customer_#{rand_id(n)}" }
      sequence(:email) { |n| "test_customer_#{rand_id(n)}@example.com" }
      sequence(:firstName) { |n| "First #{rand_id(n)}" }
      sequence(:lastName) { |n| "Last #{rand_id(n)}" }
      sequence(:companyName) { |n| "Company #{rand_id(n)}" }
      phone { '+14155555555' }
      subsidiary { create(:netsuite_subsidiary) }
    end
  end
end

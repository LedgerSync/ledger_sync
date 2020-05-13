# frozen_string_literal: true

FactoryBot.define do
  factory :customer do

    # factory :netsuite_customer, class: LedgerSync::Ledgers::NetSuite::Customer do
    #   sequence(:external_id) { |n| "customer_#{rand_id(n)}" }
    #   sequence(:email) { |n| "test_customer_#{rand_id(n)}@example.com" }
    #   sequence(:firstName) { |n| "First #{rand_id(n)}" }
    #   sequence(:lastName) { |n| "Last #{rand_id(n)}" }
    #   sequence(:companyName) { |n| "Company #{rand_id(n)}" }
    #   phone { '+14155555555' }
    #   subsidiary { create(:netsuite_subsidiary) }
    # end
  end
end

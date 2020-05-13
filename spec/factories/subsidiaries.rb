# frozen_string_literal: true

FactoryBot.define do
  factory :subsidiary do
    sequence(:name) { |n| "Test Subsidiary #{rand_id(n)}" }
    state { 'CA' }

    factory :bundle_subsidiary, class: LedgerSync::Bundles::ModernTreasury::Subsidiary do
    end

    factory :netsuite_subsidiary, class: LedgerSync::Ledgers::NetSuite::Subsidiary do
    end
  end
end

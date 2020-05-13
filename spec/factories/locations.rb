 # frozen_string_literal: true

FactoryBot.define do
  factory :location, class: LedgerSync::Bundles::ModernTreasury::Location do
    sequence(:external_id) { |n| "customer_#{rand_id(n)}" }
    sequence(:name) { |n| "Location #{rand_id(n)}" }
  end
end

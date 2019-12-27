# frozen_string_literal: true

FactoryBot.define do
  factory :subsidiary, class: LedgerSync::Subsidiary do
    sequence(:name) { |n| "Test Subsidiary #{rand_id(n)}" }
    state { 'CA' }
  end
end

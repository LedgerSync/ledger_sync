# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: LedgerSync::Item do
    sequence(:external_id) { |n| "item-#{rand_id(n)}" }
    sequence(:name) { |n| "Item #{rand_id}-#{n}" }
  end
end

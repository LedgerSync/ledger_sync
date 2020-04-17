 # frozen_string_literal: true

FactoryBot.define do
  factory :item, class: LedgerSync::Item do
    sequence(:external_id) { |n| "item_#{rand_id(n)}" }
    sequence(:name) { |n| "Test Item #{rand_id(n)}" }
    type { :non_inventory_item }
  end
end

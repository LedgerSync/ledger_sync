# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FactoryBot do
  def regex(prefix, count = 1)
    /#{prefix}-#{test_run_id}[a-zA-Z0-9]{8}-#{count}/
  end

  after do
    FactoryBot.reload
    generate_resource_factories
  end

  it 'rewinds' do
    resource_class = new_resource_class(attributes: :name)
    FactoryBot.define do
      factory :test_factory, class: resource_class do
        sequence(:name) { |n| "name-#{rand_id(n)}" }
      end
    end

    expect(FactoryBot.build(:test_factory).name).to match(regex(:name))
    FactoryBot.custom_rewind_sequences
    expect(FactoryBot.build(:test_factory).name).to match(regex(:name))
  end

  it 'supports build' do
    resource_class = new_resource_class(attributes: :name)
    FactoryBot.define do
      factory :test_factory, class: resource_class do
        sequence(:name) { |n| "name-#{rand_id(n)}" }
      end
    end
    expect(FactoryBot.build(:test_factory).name).to match(regex(:name))
  end

  it 'supports create' do
    resource_class = new_resource_class(attributes: :name)
    parent_resource_class = new_resource_class(attr_accessors: :sub_factory, attributes: :memo)
    FactoryBot.define do
      factory :test_sub_factory, class: resource_class do
        sequence(:name) { |n| "name-#{rand_id(n)}" }
      end

      factory :test_factory, class: parent_resource_class do
        sequence(:memo) { |n| "memo-#{rand_id(n)}" }
        sub_factory { create(:test_sub_factory) }
      end
    end

    resource = FactoryBot.create(:test_factory)

    expect(resource.memo).to match(regex(:memo))
    expect(resource.sub_factory.name).to match(regex(:name))
  end

  it 'supports references_one' do
    resource_class = new_resource_class(attributes: :name)
    parent_resource_class = new_resource_class(attr_accessors: :test_sub_factory)
    FactoryBot.define do
      factory :test_sub_factory, class: resource_class do
        sequence(:name) { |n| "name-#{rand_id(n)}" }
      end

      factory :test_factory, class: parent_resource_class do
        references_one :test_sub_factory
      end
    end

    expense = FactoryBot.build(:test_factory)

    expect(expense.test_sub_factory).to be_a(resource_class)
    expect(expense.test_sub_factory.name).to match(regex(:name))
  end

  it 'supports references_many' do
    resource_class = new_resource_class(attributes: :name)
    parent_resource_class = new_resource_class(attr_accessors: :test_line_items)
    FactoryBot.define do
      factory :test_line_items, class: resource_class do
        sequence(:name) { |n| "name-#{rand_id(n)}" }
      end

      factory :test_factory, class: parent_resource_class do
        references_many :test_line_items
      end
    end
    expense = FactoryBot.build(:test_factory, test_line_items: create_list(:test_line_items, 2))
    expect(expense.test_line_items.count).to eq(2)
  end
end

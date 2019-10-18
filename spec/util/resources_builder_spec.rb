# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

module LedgerSync
  class TestResource
    class ResourceWithDate < LedgerSync::Resource
      attribute :date_attr, type: Type::Date
    end

    class TestUselessResource < LedgerSync::Resource
      references_one :test_useless_resource_attribute, to: LedgerSync::Resource
    end

    class TestGrandchildResource < LedgerSync::Resource
      references_one :useless_child, to: TestResource::TestUselessResource

      attribute :test_grandchild_resource_attribute, type: Type::String
    end

    class TestChildResource < LedgerSync::Resource
      references_one :grandchild, to: TestResource::TestGrandchildResource

      attribute :test_child_resource_attribute, type: Type::String
    end

    class TestParentResource < LedgerSync::Resource
      references_many :children, to: TestResource::TestChildResource

      attribute :test_parent_resource_attribute, type: Type::String
    end
  end
end

LedgerSync.register_resource(resource: LedgerSync::TestResource::ResourceWithDate)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestUselessResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestGrandchildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestChildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestParentResource)

RSpec.describe LedgerSync::Util::ResourcesBuilder do
  include AdaptorHelpers

  context 'with date' do
    let(:data) do
      {
        resource_with_date: {
          date_resource_1: {
            data: {
              date_attr: '2019-01-01'
            }
          }
        }
      }
    end
    let(:root_resource_external_id) { :date_resource_1 }
    let(:root_resource_type) { :resource_with_date }

    let(:builder) do
      described_class.new(
        data: data,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
    end
    let(:resource) { builder.resource }
    let(:resources) { builder.resources }

    it do
      expect(resource.date_attr).to be_a(Date)
    end

    it do
      builder = described_class.new(
        data: data,
        cast: false,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
      expect(data[:resource_with_date][:date_resource_1][:data][:date_attr]).to eq('2019-01-01')
      expect { builder.resource }.to raise_error(LedgerSync::ResourceError::AttributeTypeError)
    end
  end

  context 'with references' do
    let(:data) do
      {
        test_parent_resource: {
          test_parent_resource_external_id: {
            data: {
              children: [
                :test_child_resource_external_id,
                :test_child2_resource_external_id
              ],
              test_parent_resource_attribute: :test_parent_resource_value
            }
          }
        },
        test_child_resource: {
          test_child_resource_external_id: {
            data: {
              grandchild: :test_grandchild_resource_external_id,
              test_child_resource_attribute: :test_child_resource_value
            }
          },
          test_child2_resource_external_id: {
            data: {
              test_child_resource_attribute: :test_child2_resource_value
            }
          }
        },
        test_grandchild_resource: {
          test_grandchild_resource_external_id: {
            data: {
              test_grandchild_resource_attribute: :test_grandchild_resource_value
            }
          }
        }
      }
    end

    let(:root_resource_external_id) { :test_parent_resource_external_id }
    let(:root_resource_type) { :test_parent_resource }

    let(:builder) do
      described_class.new(
        data: data,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
    end
    let(:resource) { builder.resource }
    let(:resources) { builder.resources }
    let(:parent) { resource }
    let(:child) { parent.children.first }
    let(:child2) { parent.children.last }
    let(:grandchild) { child.grandchild }

    it do
      expect(resource).to be_a(LedgerSync::TestResource::TestParentResource)
      expect(resources.count).to eq(4)

      expect(child).to be_a(LedgerSync::TestResource::TestChildResource)
      expect(child.external_id).to eq('test_child_resource_external_id')

      expect(child2).to be_a(LedgerSync::TestResource::TestChildResource)
      expect(child2.external_id).to eq('test_child2_resource_external_id')

      expect(grandchild).to be_a(LedgerSync::TestResource::TestGrandchildResource)
      expect(grandchild.external_id).to eq('test_grandchild_resource_external_id')
      expect(grandchild.useless_child).to be_nil
    end
  end
end

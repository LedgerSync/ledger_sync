require 'spec_helper'

support :adaptor_helpers

module LedgerSync
  class TestResource
    class TestUselessResource < LedgerSync::Resource
      attribute :test_useless_resource_attribute
    end

    class TestGrandchildResource < LedgerSync::Resource
      reference :useless_child,  TestResource::TestUselessResource

      attribute :test_grandchild_resource_attribute
    end

    class TestChildResource < LedgerSync::Resource
      reference :grandchild,  TestResource::TestGrandchildResource

      attribute :test_child_resource_attribute
    end

    class TestParentResource < LedgerSync::Resource
      reference :child, TestResource::TestChildResource
      reference :child2, TestResource::TestChildResource

      attribute :test_parent_resource_attribute
    end
  end
end

LedgerSync.register_resource(resource: LedgerSync::TestResource::TestUselessResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestGrandchildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestChildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestParentResource)

RSpec.describe LedgerSync::Util::ResourcesBuilder do
  include AdaptorHelpers

  let(:data) do
    {
      test_parent_resource: {
        test_parent_resource_external_id: {
          data: {
            child: :test_child_resource_external_id,
            child2: :test_child2_resource_external_id,
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
  let(:child) { parent.child }
  let(:child2) { parent.child2 }
  let(:grandchild) { child.grandchild }

  it do
    expect(resource).to be_a(LedgerSync::TestResource::TestParentResource)
    expect(resources.count).to eq(4)

    expect(child).to be_a(LedgerSync::TestResource::TestChildResource)
    expect(child.external_id).to eq(:test_child_resource_external_id)

    expect(child2).to be_a(LedgerSync::TestResource::TestChildResource)
    expect(child2.external_id).to eq(:test_child2_resource_external_id)

    expect(grandchild).to be_a(LedgerSync::TestResource::TestGrandchildResource)
    expect(grandchild.external_id).to eq(:test_grandchild_resource_external_id)
    expect(grandchild.useless_child).to be_nil
  end
end
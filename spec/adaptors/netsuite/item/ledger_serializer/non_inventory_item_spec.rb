# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Item::LedgerSerializer do
  include NetSuiteHelpers

  let(:resource_type) { :item }
  let(:id) { '123' }
  let(:name) { 'Item Name' }
  let(:resource) do
    FactoryBot.create(
      resource_type,
      ledger_id: id,
      name: name
    )
  end

  let(:h) { netsuite_records.item.non_inventory_item.hash }

  xdescribe '#to_ledger_hash' do
    let(:serializer) { described_class.new(resource: resource) }

    it do
      expect(serializer.to_ledger_hash).to eq(h.slice('id', 'name', 'type'))
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync.resources[resource_type].new }
    let(:serializer) { described_class.new(resource: resource) }
    let(:deserialized_resource) { serializer.deserialize(hash: h) }

    it do
      ledger_hash = netsuite_records.item.non_inventory_item.hash
      deserialized_resource = serializer.deserialize(hash: ledger_hash)
      expect(deserialized_resource.ledger_id).to eq('5')
      expect(deserialized_resource.name).to eq('Test Item')
      expect(deserialized_resource.type).to eq(:non_inventory_item)
    end
  end
end

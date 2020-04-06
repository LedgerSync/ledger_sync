# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Location::LedgerSerializer do
  let(:resource_type) { :location }
  let(:id) { '123' }
  let(:resource) { FactoryBot.create(resource_type, ledger_id: id) }

  let(:h) do
    {
      'links' => [
        {
          'rel' => 'self',
          'href' => 'https://test.suitetalk.api.netsuite.com/services/rest/record/v1/location/1'
        }
      ],
      'id' => id
    }
  end

  describe '#to_ledger_hash' do
    let(:serializer) { described_class.new(resource: resource) }

    it do
      expect(serializer.to_ledger_hash).to eq(h.slice('id'))
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync.resources[resource_type].new }
    let(:serializer) { described_class.new(resource: resource) }
    let(:deserialized_resource) { serializer.deserialize(hash: h) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
    end
  end
end

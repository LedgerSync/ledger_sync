# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Location::Deserializer do
  let(:resource_type) { :location }
  let(:id) { '123' }
  let(:name) { 'Location Name' }

  let(:h) do
    {
      'links' => [
        {
          'rel' => 'self',
          'href' => 'https://test.suitetalk.api.netsuite.com/services/rest/record/v1/location/1'
        }
      ],
      'id' => id,
      'name' => name
    }
  end

  describe '#deserialize' do
    let(:resource) { described_class.inferred_client_class.resources[resource_type].new }
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: resource) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.name).to eq(name)
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Location::Serializer do
  let(:resource_type) { :location }
  let(:id) { '123' }
  let(:name) { 'Location Name' }
  let(:resource) do
    FactoryBot.create(
      resource_type,
      ledger_id: id,
      name: name
    )
  end

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

  describe '#serialize' do
    let(:serializer) { described_class.new }

    it do
      expect(serializer.serialize(resource: resource)).to eq(h.slice('name'))
    end
  end
end

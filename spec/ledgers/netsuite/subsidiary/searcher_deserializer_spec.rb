# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Subsidiary::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:name) { 'Test Subsidiary' }

  let(:h) do
    {
      'id' => id,
      'name' => name
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) do
      serializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::Subsidiary.new)
    end

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.name).to eq(name)
    end
  end
end

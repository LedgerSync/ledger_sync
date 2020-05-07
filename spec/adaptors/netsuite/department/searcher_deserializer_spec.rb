# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Department::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:name) { 'department asdf' }
  let(:isinactive) { 'T' }

  let(:h) do
    {
      'id' => id,
      'name' => name,
      'isinactive' => isinactive
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: LedgerSync::Department.new) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.name).to eq(name)
      expect(deserialized_resource.active).to be_falsey
    end
  end
end

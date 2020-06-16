# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Check::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:memo) { 'Hello World' }
  let(:trandate) { '5/11/2020' }

  let(:h) do
    {
      'id' => id,
      'memo' => memo,
      'trandate' => trandate
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::Check.new) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.memo).to eq(memo)
      expect(deserialized_resource.trandate).to eq(trandate)
    end
  end
end

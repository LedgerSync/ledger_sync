# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::CustomerDeposit::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:payment) { 12.20 }
  let(:undepFunds) { false }

  let(:h) do
    {
      'id' => id,
      'payment' => payment,
      'undepFunds' => undepFunds
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::CustomerDeposit.new) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.payment).to eq(payment)
      expect(deserialized_resource.undepFunds).to be_falsey
    end
  end
end

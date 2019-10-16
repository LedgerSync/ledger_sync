# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::LedgerSerializer do
  include LedgerSerializerHelpers

  it { expect(described_class).to respond_to(:attribute) }
  it { expect(described_class).to respond_to(:references_many) }
  it { expect(described_class).to respond_to(:id) }

  describe '#to_ledger_hash' do
    it do
      resource = LedgerSync::Customer.new
      serializer = LedgerSync::Adaptors::QuickBooksOnline::Customer::LedgerSerializer.new(resource: resource)

      expect(serializer.to_ledger_hash(only_changes: true)).to eq({})
      resource.name = 'Testing'
      expect(serializer.to_ledger_hash(only_changes: true)).to eq( 'DisplayName' => 'Testing' )
    end
  end
end
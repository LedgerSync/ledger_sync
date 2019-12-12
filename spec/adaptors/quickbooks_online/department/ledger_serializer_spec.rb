# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Department::LedgerSerializer do
  describe '#to_ledger_hash' do
    describe 'without parent' do
      let(:department) { LedgerSync::Department.new(name: 'Department') }

      it 'does not include ParentRef' do
        serializer = described_class.new(resource: department)
        hash = serializer.to_ledger_hash

        expect(hash['ParentRef']).to eq(nil)
      end
    end

    describe 'with parent' do
      let(:parent) { LedgerSync::Department.new(ledger_id: '123', name: 'Parent') }
      let(:department) { LedgerSync::Department.new(name: 'Department', parent: parent) }

      it 'does include ParentRef with value' do
        serializer = described_class.new(resource: department)
        hash = serializer.to_ledger_hash

        expect(hash['ParentRef']).to eq({"value" => "123"})
      end
    end

    describe 'with explicitly no parent' do
      let(:department) { LedgerSync::Department.new(name: 'Department', parent: nil) }

      it 'does include ParentRef without value' do
        serializer = described_class.new(resource: department)
        hash = serializer.to_ledger_hash

        expect(hash['ParentRef']).to eq({"value" => nil})
      end
    end
  end
end

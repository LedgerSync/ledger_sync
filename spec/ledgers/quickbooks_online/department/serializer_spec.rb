# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Serializer do
  describe '#serialize' do
    describe 'without parent' do
      let(:department) { create(:quickbooks_online_department, name: 'Department') }

      it 'does not include ParentRef' do
        serializer = described_class.new
        hash = serializer.serialize(resource: department)

        expect(hash).to have_key('ParentRef')
        expect(hash['ParentRef']).to be_nil
      end
    end

    describe 'with parent' do
      let(:parent) { create(:quickbooks_online_department, ledger_id: '123', name: 'Parent') }
      let(:department) { create(:quickbooks_online_department, name: 'Department', parent: parent) }

      it 'does include ParentRef with value' do
        serializer = described_class.new
        hash = serializer.serialize(resource: department)

        expect(hash['ParentRef']).to eq({ 'value' => '123' })
      end
    end

    describe 'with explicitly no parent' do
      let(:department) { create(:quickbooks_online_department, name: 'Department', parent: nil) }

      it 'does include ParentRef without value' do
        serializer = described_class.new
        hash = serializer.serialize(resource: department)

        expect(hash).to have_key('ParentRef')
        expect(hash['ParentRef']).to be_nil
      end
    end
  end
end

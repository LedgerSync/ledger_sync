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
      expect(serializer.to_ledger_hash(only_changes: true)).to eq('DisplayName' => 'Testing')
    end

    it 'allows multiple values in nested hash' do
      resource = LedgerSync::JournalEntryLineItem.new(
        entry_type: 'debit',
        account: LedgerSync::Account.new(
          ledger_id: 'adsf'
        )
      )
      serializer = LedgerSync::Adaptors::QuickBooksOnline::JournalEntryLineItem::LedgerSerializer.new(resource: resource)

      h = {
        'Amount' => nil,
        'Description' => nil,
        'DetailType' => 'JournalEntryLineDetail',
        'JournalEntryLineDetail' => {
          'PostingType' => 'Debit',
          'AccountRef' => {
            'value' => 'adsf'
          }
        }
      }

      expect(serializer.to_ledger_hash).to eq(h)
    end
  end
end

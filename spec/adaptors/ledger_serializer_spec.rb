# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::LedgerSerializer do
  include LedgerSerializerHelpers

  let(:test_serializer_class) do
    Class.new(LedgerSync::Adaptors::LedgerSerializer) do
      attribute ledger_attribute: :name,
                resource_attribute: :name,
                serialize: false,
                deserialize: true
      attribute ledger_attribute: :phone_number,
                resource_attribute: :phone_number,
                serialize: true,
                deserialize: false

      # Default true
      attribute ledger_attribute: :email,
                resource_attribute: :email
    end
  end

  let(:test_serializer) do
    test_serializer_class.new(
      ensure_inferred_resource_class: false,
      resource: test_resource
    )
  end

  let(:test_resource) do
    LedgerSync::Customer.new(
      name: 'test_name',
      phone_number: 'test_phone',
      email: 'test_email'
    )
  end

  it { expect(described_class).to respond_to(:attribute) }
  it { expect(described_class).to respond_to(:references_many) }
  it { expect(described_class).to respond_to(:id) }

  describe '#deserialize' do
    it do
      h = {
        name: 'test_name',
        phone_number: 'test_phone',
        email: 'test_email'
      }
      test_serializer = test_serializer_class.new(
        ensure_inferred_resource_class: false,
        resource: LedgerSync::Customer.new
      )
      resource = LedgerSync::Customer.new(**h.except(:phone_number))
      deserialized_resource = test_serializer.deserialize(hash: h)
      expect(deserialized_resource).to eq(resource)
    end
  end

  describe '#to_ledger_hash' do
    it do
      h = {
        'phone_number' => 'test_phone',
        'email' => 'test_email'
      }
      expect(test_serializer.to_ledger_hash).to eq(h)
    end

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

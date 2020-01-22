# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::LedgerSerializer do
  include LedgerSerializerHelpers

  let(:resource) do
    LedgerSync::Account.new(
      account_sub_type: account_sub_type,
      account_type: account_type,
      active: active,
      classification: classification,
      currency: currency,
      description: description,
      name: name,
      number: number
    )
  end
  let(:name) { 'account_name' }
  let(:account_type) { 'bank' }
  let(:account_sub_type) { 'cash_on_hand' }
  let(:number) { '123' }
  let(:classification) { 'asset' }
  let(:currency) { FactoryBot.create(:currency, exchange_rate: nil) }
  let(:description) { 'A descirption' }
  let(:active) { true }

  let(:h) do
    {
      'Name' => name,
      'AccountType' => LedgerSync::Adaptors::QuickBooksOnline::LedgerSerializerType::AccountType.mapping[account_type],
      'AccountSubType' => LedgerSync::Adaptors::QuickBooksOnline::LedgerSerializerType::AccountSubType.mapping[account_sub_type],
      'AcctNum' => number,
      'Classification' => LedgerSync::Adaptors::QuickBooksOnline::LedgerSerializerType::ClassificationType.mapping[classification],
      'CurrencyRef' => {
        'name' => currency.name,
        'value' => currency.symbol
      },
      'Description' => description,
      'Id' => nil,
      'Active' => active
    }
  end

  describe '#to_ledger_hash' do
    it do
      serializer = described_class.new(resource: resource)
      expect(serializer.to_ledger_hash).to eq(h)
    end
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Customer.new }

    it do
      expect_deserialized_attributes(
        attributes: %i[
          account_sub_type
          account_type
          active
          currency
          description
          name
          number
        ],
        resource: LedgerSync::Account.new,
        response_hash: h,
        serializer_class: described_class,
        values: {
          account_sub_type: account_sub_type,
          account_type: account_type
        }
      )
    end
  end
end

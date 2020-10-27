# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account::Serializer do
  include SerializationHelpers

  let(:resource) do
    create(
      :quickbooks_online_account,
      AccountSubType: account_sub_type,
      AccountType: account_type,
      Active: active,
      Classification: classification,
      Currency: currency,
      Description: description,
      ledger_id: nil,
      Name: name,
      AcctNum: number
    )
  end
  let(:name) { 'account_name' }
  let(:account_type) { 'bank' }
  let(:account_sub_type) { 'cash_on_hand' }
  let(:number) { '123' }
  let(:classification) { 'asset' }
  let(:currency) { FactoryBot.create(:quickbooks_online_currency) }
  let(:description) { 'A descirption' }
  let(:active) { true }

  let(:h) do
    {
      'Name' => name,
      'AccountType' => LedgerSync::Ledgers::QuickBooksOnline::Account::TYPES[account_type],
      'AccountSubType' => LedgerSync::Ledgers::QuickBooksOnline::Account::SUB_TYPES[account_sub_type],
      'AcctNum' => number,
      'Classification' => LedgerSync::Ledgers::QuickBooksOnline::Account::CLASSIFICATIONS[classification],
      'CurrencyRef' => {
        'value' => currency.Symbol
      },
      'Description' => description,
      'Active' => active,
      'Id' => nil
    }
  end

  describe '#serialize' do
    it do
      serializer = described_class.new
      expect(serializer.serialize(resource: resource)).to eq(h)
    end
  end
end

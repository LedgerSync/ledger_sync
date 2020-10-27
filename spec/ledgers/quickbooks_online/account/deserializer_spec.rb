# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account::Deserializer do
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
  let(:classification) { nil }
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
        'name' => currency.Name,
        'value' => currency.Symbol
      },
      'Description' => description,
      'Id' => nil,
      'Active' => active
    }
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new }

    it do
      expect_deserialized_attributes(
        attributes: %i[
          AccountSubType
          AccountType
          Classification
          Active
          Description
          Name
          AcctNum
        ],
        resource: LedgerSync::Ledgers::QuickBooksOnline::Account.new,
        response_hash: h,
        deserializer_class: described_class,
        values: {
          AccountSubType: account_sub_type,
          AccountType: account_type,
          Classification: 'asset',
          Active: active,
          Currency: currency,
          Description: description,
          Name: name,
          AcctNum: number
        }
      )
    end
  end
end

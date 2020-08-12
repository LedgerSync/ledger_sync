# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense::Deserializer do
  include SerializationHelpers

  let(:account) do
    build(
      :quickbooks_online_account,
      ledger_id: 'account_ledger_id'
    )
  end
  let(:department) do
    build(
      :quickbooks_online_department,
      ledger_id: 'department_ledger_id'
    )
  end
  let(:ledger_class) do
    build(
      :quickbooks_online_ledger_class,
      ledger_id: 'class_ledger_id'
    )
  end
  let(:vendor_ledger_id) { 'vendor_ledger_id' }
  let(:vendor_display_name) { 'Test Vendor' }
  let(:entity_type) { 'Vendor' }
  let(:vendor) do
    build(
      :quickbooks_online_vendor,
      ledger_id: vendor_ledger_id,
      DisplayName: vendor_display_name
    )
  end
  let(:resource) do
    build(
      :quickbooks_online_expense,
      Account: account,
      Department: department,
      Currency: currency,
      ExchangeRate: exchange_rate,
      PrivateNote: memo,
      TxnDate: transaction_date,
      DocNumber: 'Ref123',
      Entity: vendor,
      Line: line_items
    )
  end
  let(:currency) do
    build(
      :quickbooks_online_currency
    )
  end

  let(:line_items) do
    # Account is required:
    # https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/purchase#create-a-purchase
    [
      build(
        :quickbooks_online_expense_line,
        Amount: 10_000,
        Description: 'Description 1',
        AccountBasedExpenseLineDetail: build(
          :quickbooks_online_account_based_expense_line_detail,
          Account: build(
            :quickbooks_online_account,
            ledger_id: 'account_ledger_id_1'
          ),
          Class: ledger_class
        )
      ),
      build(
        :quickbooks_online_expense_line,
        Amount: 20_000,
        Description: 'Description 2',
        AccountBasedExpenseLineDetail: build(
          :quickbooks_online_account_based_expense_line_detail,
          Account: build(
            :quickbooks_online_account,
            ledger_id: 'account_ledger_id_2'
          ),
          Class: ledger_class
        )
      )
    ]
  end
  let(:memo) { 'Test Expense' }
  let(:payment_type) { 'cash' }
  let(:exchange_rate) { 0.987 }
  let(:transaction_date) { Date.yesterday }

  let(:h) do
    {
      'Id' => nil,
      'CurrencyRef' => {
        'name' => currency.Name,
        'value' => currency.Symbol
      },
      'DepartmentRef' => { 'value' => department.ledger_id },
      'DocNumber' => 'Ref123',
      'PaymentType' => LedgerSync::Ledgers::QuickBooksOnline::Expense::PAYMENT_TYPES[payment_type],
      'TxnDate' => transaction_date.to_s, # Format: YYYY-MM-DD
      'PrivateNote' => memo,
      'ExchangeRate' => exchange_rate,
      'EntityRef' => {
        'value' => vendor_ledger_id,
        'name' => vendor_display_name,
        'type' => entity_type
      },
      'AccountRef' => {
        'value' => account.ledger_id
      },
      'Line' => line_items.map do |line_item|
        LedgerSync::Ledgers::QuickBooksOnline::ExpenseLine::Serializer.new.serialize(
          resource: line_item
        )
      end
    }
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new }

    it do
      deserialized_resource = expect_deserialized_attributes(
        attributes: %i[
          ExchangeRate
          PrivateNote
          PaymentType
          TxnDate
        ],
        resource: LedgerSync::Ledgers::QuickBooksOnline::Expense.new,
        response_hash: h,
        deserializer_class: described_class,
        values: {
          ExchangeRate: exchange_rate,
          PrivateNote: memo,
          PaymentType: payment_type,
          TxnDate: transaction_date,
          Currency: currency
        }
      )

      entity = deserialized_resource.Entity
      expect(entity).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Vendor)
      expect(entity.ledger_id).to eq(vendor_ledger_id)
    end
  end
end

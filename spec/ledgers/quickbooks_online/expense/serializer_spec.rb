# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense::Serializer do
  include SerializationHelpers

  let(:account) { LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: 'account_ledger_id') }
  let(:department) { LedgerSync::Ledgers::QuickBooksOnline::Department.new(ledger_id: 'department_ledger_id') }
  let(:ledger_class) { LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: 'class_ledger_id') }
  let(:vendor_ledger_id) { 'vendor_ledger_id' }
  let(:vendor_display_name) { 'Test Vendor' }
  let(:entity_type) { 'Vendor' }
  let(:vendor) do
    LedgerSync::Ledgers::QuickBooksOnline::Vendor.new(
      display_name: vendor_display_name,
      ledger_id: vendor_ledger_id
    )
  end
  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Expense.new(
      account: account,
      department: department,
      currency: currency,
      exchange_rate: exchange_rate,
      line_items: line_items,
      memo: memo,
      payment_type: payment_type,
      reference_number: 'Ref123',
      transaction_date: transaction_date,
      entity: vendor
    )
  end
  let(:currency) { FactoryBot.create(:quickbooks_online_currency) }
  let(:line_items) do
    # Account is required:
    # https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/purchase#create-a-purchase
    [
      LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem.new(
        account: LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: 'account_ledger_id_1'),
        ledger_class: ledger_class,
        amount: 10_000,
        description: 'Description 1'
      ),
      LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem.new(
        account: LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: 'account_ledger_id_2'),
        ledger_class: ledger_class,
        amount: 20_000,
        description: 'Description 2'
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
        'value' => currency.symbol
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
        LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem::Serializer.new.serialize(
          resource: line_item
        )
      end
    }
  end

  describe '#serialize' do
    it do
      serializer = described_class.new
      expect(serializer.serialize(resource: resource)).to eq(h)
    end
  end
end

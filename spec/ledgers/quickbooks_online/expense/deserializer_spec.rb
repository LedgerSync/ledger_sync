# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense::Deserializer do
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
    [
      LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem.new(
        account: LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: 'account_ledger_id_1'), # Account is required: https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/purchase#create-a-purchase
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
        'name' => currency.name,
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

  describe '#deserialize' do
    let(:customer) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new }

    it do
      deserialized_resource = expect_deserialized_attributes(
        attributes: %i[
          account
          exchange_rate
          memo
          payment_type
          transaction_date
        ],
        resource: LedgerSync::Ledgers::QuickBooksOnline::Expense.new,
        response_hash: h,
        deserializer_class: described_class,
        values: {
          currency: currency
        }
      )

      line_items.each do |li|
        expect(deserialized_resource.line_items).to include(li)
      end

      entity = deserialized_resource.entity
      expect(entity).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Vendor)
      expect(entity.ledger_id).to eq(vendor_ledger_id)
      expect(entity.display_name).to eq(vendor_display_name)
    end
  end
end

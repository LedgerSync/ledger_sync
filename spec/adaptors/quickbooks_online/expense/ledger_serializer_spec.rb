# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::LedgerSerializer do
  include LedgerSerializerHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: 'account_ledger_id') }
  let(:vendor_ledger_id) { 'vendor_ledger_id' }
  let(:vendor_display_name) { 'Test Vendor' }
  let(:entity_type) { 'Vendor' }
  let(:vendor) do
    LedgerSync::Vendor.new(
      display_name: vendor_display_name,
      ledger_id: vendor_ledger_id
    )
  end
  let(:resource) do
    LedgerSync::Expense.new(
      account: account,
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
  let(:currency) { FactoryBot.create(:currency) }
  let(:line_items) do
    [
      LedgerSync::ExpenseLineItem.new(
        account: LedgerSync::Account.new(ledger_id: 'account_ledger_id_1'), # Account is required: https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/purchase#create-a-purchase
        amount: 10_000,
        description: 'Description 1'
      ),
      LedgerSync::ExpenseLineItem.new(
        account: LedgerSync::Account.new(ledger_id: 'account_ledger_id_2'),
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
      'DocNumber' => 'Ref123',
      'PaymentType' => LedgerSync::Adaptors::QuickBooksOnline::LedgerSerializerType::PaymentType.mapping[payment_type],
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
        LedgerSync::Adaptors::QuickBooksOnline::ExpenseLineItem::LedgerSerializer.new(
          resource: line_item
        ).to_ledger_hash
      end
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
      deserialized_resource = expect_deserialized_attributes(
        attributes: %i[
          account
          exchange_rate
          memo
          payment_type
          transaction_date
        ],
        resource: LedgerSync::Expense.new,
        response_hash: h,
        serializer_class: described_class
      )

      expect(deserialized_resource.currency.symbol).to eq(currency.symbol)

      line_items.each do |li|
        expect(deserialized_resource.line_items).to include(li)
      end

      entity = deserialized_resource.entity
      expect(entity).to be_a(LedgerSync::Vendor)
      expect(entity.ledger_id).to eq(vendor_ledger_id)
      expect(entity.display_name).to eq(vendor_display_name)
    end
  end
end

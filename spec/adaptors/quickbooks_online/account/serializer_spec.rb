# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::Serializer do
  let(:account) { LedgerSync::Account.new(ledger_id: 'account_ledger_id') }
  let(:resource) do
    LedgerSync::ExpenseLineItem.new(
      account: account,
      amount: amount,
      description: description
    )
  end
  let(:amount) { 30_000 }
  let(:description) { 'Test Expense Line Item' }

  let(:h) do
    {
      'CurrencyRef' => {
        'value' => currency,
      },
      'PaymentType' => payment_type,
      'TxnDate' => transaction_date.to_s, # Format: YYYY-MM-DD
      'PrivateNote' => memo,
      'ExchangeRate' => exchange_rate,
      'EntityRef' => {
        'value' => vendor.ledger_id
      },
      'AccountRef' => {
        'value' => account.ledger_id
      },
      'Line' => line_items.map do |line_item|
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'AccountBasedExpenseLineDetail' => {
            'AccountRef' => {
              'value' => line_item.account&.ledger_id || account.ledger_id
            }
          },
          'Amount' => line_item.amount / 100.0,
          'Description' => line_item.description
        }
      end
    }
  end

  describe '#to_h' do
    it do
      serializer = described_class.new(resource: customer)
      expect(serializer.to_h).to eq(h.reject { |e| e == 'Id' })
    end

    it do
      resource =

      serializer = LedgerSync::Adaptors::QuickBooksOnline::Expense::Serializer.new(resource: resource)
      h = {

      }
      expect(serializer.to_h).to eq(h)
    end
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Customer.new }

    it do
      serializer = described_class.new(resource: customer)
      deserialized_customer = serializer.deserialize(h)
      expect(customer.email).to be_nil
      expect(customer.name).to be_nil
      expect(customer.phone_number).to be_nil
      expect(deserialized_customer.email).to eq(email)
      expect(deserialized_customer.name).to eq(name)
      expect(deserialized_customer.phone_number).to eq(phone_number)
    end

    xit do
      resource = LedgerSync::Expense.new(
        account: LedgerSync::Account.new(ledger_id: 'account_ledger_id'),
        amount: 30_000,
        currency: 'USD',
        line_items: [
          LedgerSync::ExpenseLineItem.new(
            amount: 10_000,
            description: 'Description 1'
          ),
          LedgerSync::ExpenseLineItem.new(
            amount: 20_000,
            description: 'Description 2'
          )
        ],
        memo: 'Test Expense',
        payment_type: 'cash',
        transaction_date: Date.new(2019, 1, 2),
        vendor: LedgerSync::Vendor.new(ledger_id: 'vendor_ledger_id')
      )

      serializer = LedgerSync::Adaptors::QuickBooksOnline::Expense::Serializer.new(resource: resource)
    end
  end
end

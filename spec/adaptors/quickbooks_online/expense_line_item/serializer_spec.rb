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
      'DetailType' => 'AccountBasedExpenseLineDetail',
      'AccountBasedExpenseLineDetail' => {
        'AccountRef' => {
          'value' => account.ledger_id
        }
      },
      'Amount' => amount / 100.0,
      'Description' => description
    }
  end

  describe '#to_h' do
    it do
      serializer = described_class.new(resource: resource)
      expect(serializer.to_h).to eq(h.reject { |e| e == 'Id' })
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync::Expense.new }

    it do
      serializer = described_class.new(resource: resource)
      deserialized_resource = serializer.deserialize(h)
      expect(resource.account).to be_nil
      expect(resource.amount).to be_nil
      expect(resource.description).to be_nil
      expect(deserialized_resource.account).to eq(account)
      expect(deserialized_resource.amount).to eq(amount)
      expect(deserialized_resource.description).to eq(description)
    end
  end
end

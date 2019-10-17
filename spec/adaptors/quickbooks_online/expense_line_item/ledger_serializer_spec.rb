# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::ExpenseLineItem::LedgerSerializer do
  include LedgerSerializerHelpers

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
      'Id' => nil,
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

  describe '#to_ledger_hash' do
    it do
      serializer = described_class.new(resource: resource)
      expect(serializer.to_ledger_hash).to eq(h)
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync::Expense.new }

    it do
      expect_deserialized_attributes(
        attributes: %i[
          account
          amount
          description
        ],
        response_hash: h,
        serializer_class: described_class
      )
    end
  end
end

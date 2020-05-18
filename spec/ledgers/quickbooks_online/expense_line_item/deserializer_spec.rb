# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem::Deserializer do
  include SerializationHelpers

  let(:account) { LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: 'account_ledger_id') }
  let(:ledger_class) { LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: 'class_ledger_id') }
  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem.new(
      account: account,
      ledger_class: ledger_class,
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
        },
        'ClassRef' => {
          'value' => ledger_class.ledger_id
        }
      },
      'Amount' => amount / 100.0,
      'Description' => description
    }
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
        deserializer_class: described_class
      )
    end
  end
end

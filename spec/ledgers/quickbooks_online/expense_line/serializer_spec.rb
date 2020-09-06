# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::ExpenseLine::Serializer do
  include SerializationHelpers

  let(:account) do
    build(
      :quickbooks_online_account,
      ledger_id: 'account_ledger_id'
    )
  end

  let(:ledger_class) do
    build(
      :quickbooks_online_ledger_class,
      ledger_id: 'class_ledger_id'
    )
  end

  let(:amount) { 30_000 }
  let(:description) { 'Test Expense Line Item' }

  let(:resource) do
    build(
      :quickbooks_online_expense_line,
      Amount: amount,
      Description: description,
      AccountBasedExpenseLineDetail: build(
        :quickbooks_online_account_based_expense_line_detail,
        Account: account,
        Class: ledger_class
      )
    )
  end

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

  describe '#serialize' do
    it do
      serializer = described_class.new
      expect(serializer.serialize(resource: resource)).to eq(h)
    end
  end
end

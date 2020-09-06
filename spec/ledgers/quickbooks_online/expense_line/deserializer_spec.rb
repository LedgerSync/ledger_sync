# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::ExpenseLine::Deserializer do
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

  describe '#deserialize' do
    it do
      expect_deserialized_attributes(
        attributes: %i[
          Amount
          Description
        ],
        resource: LedgerSync::Ledgers::QuickBooksOnline::ExpenseLine.new,
        response_hash: h,
        deserializer_class: described_class,
        values: {
          Amount: amount,
          Description: description
        }
      )
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::JournalEntry::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account1) do
    build(
      :quickbooks_online_account,
      ledger_id: '123'
    )
  end

  let(:account2) do
    build(
      :quickbooks_online_account,
      ledger_id: '123'
    )
  end

  let(:department) do
    build(
      :quickbooks_online_department,
      ledger_id: '123'
    )
  end

  let(:ledger_class) do
    build(
      :quickbooks_online_ledger_class,
      ledger_id: '123'
    )
  end

  let(:line_item_1) do
    build(
      :quickbooks_online_journal_entry_line,
      ledger_id: nil,
      Amount: 12_345,
      Description: 'Sample Transaction',
      JournalEntryLineDetail: build(
        :quickbooks_online_journal_entry_line_detail,
        Account: account1,
        Class: ledger_class,
        Department: department,
        PostingType: 'credit'
      )
    )
  end

  let(:line_item_2) do
    build(
      :quickbooks_online_journal_entry_line,
      ledger_id: nil,
      Amount: 12_345,
      Description: 'Sample Transaction',
      JournalEntryLineDetail: build(
        :quickbooks_online_journal_entry_line_detail,
        Account: account2,
        Class: ledger_class,
        Department: department,
        PostingType: 'debit'
      )
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_journal_entry,
      ledger_id: '123',
      DocNumber: 'Ref123',
      PrivateNote: 'Memo',
      TxnDate: Date.parse('2019-09-01'),
      Currency: build(
        :quickbooks_online_currency,
        Symbol: 'USD',
        Name: 'United States Dollar'
      ),
      Line: [
        line_item_1,
        line_item_2
      ]
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_journal_entry_find
                    stub_journal_entry_update
                  ]
end

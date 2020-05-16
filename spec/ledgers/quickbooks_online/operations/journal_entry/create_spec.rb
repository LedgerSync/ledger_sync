# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::JournalEntry::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account1) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  let(:account2) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  let(:department) do
    LedgerSync::Ledgers::QuickBooksOnline::Department.new(ledger_id: '123')
  end

  let(:ledger_class) do
    LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: '123')
  end

  let(:line_item_1) do
    LedgerSync::Ledgers::QuickBooksOnline::JournalEntryLineItem.new(journal_entry_line_item_resource(account: account1, ledger_class: ledger_class, department: department, entry_type: 'credit'))
  end

  let(:line_item_2) do
    LedgerSync::Ledgers::QuickBooksOnline::JournalEntryLineItem.new(journal_entry_line_item_resource(account: account2, ledger_class: ledger_class, department: department, entry_type: 'debit'))
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::JournalEntry.new(
      journal_entry_resource(
        line_items: [
          line_item_1,
          line_item_2
        ]
      )
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_journal_entry
end

# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::JournalEntry::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:resource) do
    LedgerSync::JournalEntry.new(
      ledger_id: '123',
      reference_number: 'Ref123',
      currency: FactoryBot.create(:currency),
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      line_items: []
    )
  end
  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_journal_entry
end

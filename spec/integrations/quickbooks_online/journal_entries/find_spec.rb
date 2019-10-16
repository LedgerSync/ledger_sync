require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/journal_entries/find', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before {
    stub_find_journal_entry
  }

  let(:account1) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:account2) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:line_item_1) do
    LedgerSync::JournalEntryLineItem.new(journal_entry_line_item_resource({account: account1, entry_type: 'credit'}))
  end

  let(:line_item_2) do
    LedgerSync::JournalEntryLineItem.new(journal_entry_line_item_resource({account: account2, entry_type: 'debit'}))
  end

  let(:resource) do
    LedgerSync::JournalEntry.new(
      journal_entry_resource(
        {
          ledger_id: '123',
          line_items: [
            line_item_1,
            line_item_2
          ]
        }
      )
    )
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::JournalEntry::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end

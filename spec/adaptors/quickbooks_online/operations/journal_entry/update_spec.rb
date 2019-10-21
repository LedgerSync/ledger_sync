require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::JournalEntry::Operations::Update do
  include AdaptorHelpers

  let(:journal_entry) { LedgerSync::JournalEntry.new(ledger_id: '123', reference_number: 'Ref123', currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), line_items: [])}

  it do
    instance = described_class.new(resource: journal_entry, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end

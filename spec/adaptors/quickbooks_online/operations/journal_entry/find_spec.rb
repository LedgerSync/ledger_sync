# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::JournalEntry::Operations::Find do
  include AdaptorHelpers

  let(:resource) { LedgerSync::JournalEntry.new(ledger_id: '123', reference_number: 'Ref123', currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), line_items: [])}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end

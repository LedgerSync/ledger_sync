# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/departments/search', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before do
    stub_search_ledger_class
  end

  let(:input) do
    {
      connection: quickbooks_online_connection,
      query: 'Test Class'
    }
  end

  context '#resources' do
    subject { LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

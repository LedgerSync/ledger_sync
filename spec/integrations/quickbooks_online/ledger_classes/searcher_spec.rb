# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/ledger_class/search', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before do
    stub_ledger_class_search
  end

  let(:input) do
    {
      client: quickbooks_online_client,
      query: 'Test Class'
    }
  end

  context '#resources' do
    subject { LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/departments/search', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before do
    stub_search_department
  end

  let(:input) do
    {
      client: quickbooks_online_client,
      query: 'Test Department'
    }
  end

  context '#resources' do
    subject { LedgerSync::Ledgers::QuickBooksOnline::Department::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

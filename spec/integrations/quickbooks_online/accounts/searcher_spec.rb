require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/accounts/search', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_search_account
  }

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      query: 'Sample Account'
    }
  end

  context '#resources' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Account::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

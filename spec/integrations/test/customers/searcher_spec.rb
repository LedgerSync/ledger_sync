require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/customers/search', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input) do
    {
      adaptor: test_adaptor,
      query: 'Sample Customer'
    }
  end

  context '#resources' do
    subject { LedgerSync::Adaptors::Test::Customer::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

require 'spec_helper'

support :input_helpers
support :test_adaptor_helpers

RSpec.describe 'test/vendors/search', type: :feature do
  include InputHelpers
  include TestAdaptorHelpers

  let(:input) do
    {
      adaptor: test_adaptor,
      query: 'Sample Vendor'
    }
  end

  context '#resources' do
    subject { LedgerSync::Adaptors::Test::Vendor::Searcher.new(**input).search }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Department::Searcher do
  include InputHelpers
  include NetSuiteHelpers

  before do
    stub_department_search
  end

  let(:input) do
    {
      adaptor: netsuite_adaptor,
      query: ''
    }
  end

  context '#resources' do
    subject { described_class.new(**input).search }

    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
    it { expect(subject.resources.first).to be_a(LedgerSync::Department) }
  end
end

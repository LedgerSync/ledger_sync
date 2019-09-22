require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Searcher do
  include AdaptorHelpers

  let(:adaptor) { test_adaptor }
  let(:query) { 'qqq' }

  subject { described_class.new(adaptor: adaptor, query: query) }

  describe '#next_searcher' do
    it { expect { subject.next_searcher }.to raise_error(NotImplementedError) }
  end

  describe '#previous_searcher' do
    it { expect { subject.previous_searcher }.to raise_error(NotImplementedError) }
  end

  describe '#resources' do
    it { expect { subject.resources }.to raise_error(NotImplementedError) }
  end

  describe '#search' do
    it { expect { subject.search }.to raise_error(NotImplementedError) }
  end
end

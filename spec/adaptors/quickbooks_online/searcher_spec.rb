# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Searcher do
  include TestAdaptorHelpers

  let(:adaptor) { test_adaptor }
  let(:query) { 'qqq' }

  subject { described_class.new(adaptor: adaptor, query: query) }

  describe '#next_searcher' do
    it { expect(subject.next_searcher.pagination).to eq(limit: 10, offset: 11) }
  end

  describe '#previous_searcher' do
    it { expect(subject.previous_searcher).to be_nil }
    it { expect(subject.next_searcher.previous_searcher.pagination).to eq(limit: 10, offset: 1) }
  end

  describe '#resources' do
    it { expect { subject.resources }.to raise_error(NotImplementedError) }
  end

  describe '#search' do
    it { expect { subject.search }.to raise_error(NotImplementedError) }
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Adaptor do
  include AdaptorHelpers

  it { expect { described_class.new }.to raise_error(NotImplementedError) }

  subject { test_adaptor }

  describe '#searcher_for?' do
    it { expect(subject.searcher_for?(resource_type: :customer)).to be_truthy }
    it { expect(subject.searcher_for?(resource_type: :asdf)).to be_falsey }
  end

  describe '#searcher_klass_for' do
    it { expect(subject.searcher_klass_for(resource_type: :customer)).to eq(LedgerSync::Adaptors::Test::Customer::Searcher) }
  end

  describe '#url_for' do
    let(:resource) { LedgerSync::Customer.new(ledger_id: 'abc') }
    let(:url) { 'http://example.com/customer/abc' }

    it { expect(subject.url_for(resource: resource)).to eq(url) }
  end

  describe '#ledger_attributes_to_save' do
    it { expect { described_class.ledger_attributes_to_save }.to raise_error(NotImplementedError) }
    it { expect(subject.class.ledger_attributes_to_save).to eq([]) }
  end
end

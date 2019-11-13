# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Adaptor do
  include AdaptorHelpers
  include NetSuiteHelpers

  let(:account) { 'account' }
  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }
  let(:token_id) { 'token_id' }
  let(:token_secret) { 'token_secret' }
  let(:adaptor) { netsuite_adaptor }

  subject do
    described_class.new(
      account: 'account',
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      token_id: 'token_id',
      token_secret: 'token_secret'
    )
  end

  xdescribe '#find' do
    it { expect(subject).to respond_to(:find) }
  end

  describe '#ledger_attributes_to_save' do
    it do
      h = {}
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  xdescribe '#post' do
    it { expect(subject).to respond_to(:post) }
  end

  xdescribe '#query' do
    it { expect(subject).to respond_to(:query) }
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[]) }
  end
end

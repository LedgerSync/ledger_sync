# frozen_string_literal: true

require 'spec_helper'

support :netsuite_soap_helpers

RSpec.describe LedgerSync::Ledgers::NetSuiteSOAP::Client do
  include NetSuiteSOAPHelpers

  let(:account) { 'account' }
  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }
  let(:token_id) { 'token_id' }
  let(:token_secret) { 'token_secret' }
  let(:client) { netsuite_soap_client }

  subject do
    described_class.new(
      account_id: 'account-id',
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      token_id: 'token_id',
      token_secret: 'token_secret'
    )
  end

  describe '#account_id' do
    it { expect(subject).to respond_to(:account_id) }
  end

  describe '#account_id_for_gem' do
    it { expect(subject).to respond_to(:account_id_for_gem) }
  end

  describe '#account_id_for_url' do
    it { expect(subject).to respond_to(:account_id_for_url) }
  end

  describe '#ledger_attributes_to_save' do
    it do
      h = {}
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[]) }
  end
end

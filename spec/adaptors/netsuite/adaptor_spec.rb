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

  describe '#find' do
    it { expect(subject).to respond_to(:find) }
  end

  describe '#ledger_attributes_to_save' do
    it do
      h = {}
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  describe '#post' do
    it { expect(subject).to respond_to(:post) }
  end

  describe '#query' do
    it { expect(subject).to respond_to(:query) }
  end

  xdescribe '#url_for' do
    it do
      resource = LedgerSync::Account.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/register?accountId=123')
    end

    it do
      resource = LedgerSync::Bill.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/bill?txnId=123')
    end

    it do
      resource = LedgerSync::Customer.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/customerdetail?nameId=123')
    end

    it do
      resource = LedgerSync::Deposit.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/deposit?txnId=123')
    end

    it do
      resource = LedgerSync::Expense.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/expense?txnId=123')
    end

    it do
      resource = LedgerSync::JournalEntry.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/journal?txnId=123')
    end

    it do
      resource = LedgerSync::Payment.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/recvpayment?txnId=123')
    end

    it do
      resource = LedgerSync::Transfer.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/transfer?txnId=123')
    end

    it do
      resource = LedgerSync::Vendor.new(ledger_id: 123)
      url = adaptor.url_for(resource: resource)
      expect(url).to eq('https://app.sandbox.qbo.intuit.com/app/vendordetail?nameId=123')
    end
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[]) }
  end
end

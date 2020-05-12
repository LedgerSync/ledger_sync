# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Record::Metadata do
  include NetSuiteHelpers

  let(:client) { netsuite_client }
  let(:metadata) do
    described_class.new(
      client: client,
      record: record
    )
  end

  let(:record) { :customer }

  before do
    allow_any_instance_of(LedgerSync::Ledgers::NetSuite::Token).to receive(:signature) { 'SIGNATURE' }
    allow_any_instance_of(LedgerSync::Ledgers::NetSuite::Token).to receive(:nonce) { 'NONCE' }
    allow_any_instance_of(LedgerSync::Ledgers::NetSuite::Token).to receive(:timestamp) { '1234567890' }
  end

  describe '#create' do
    subject { metadata.create }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('post /customer') }
  end

  describe '#delete' do
    subject { metadata.delete }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('delete /customer/{id}') }
  end

  describe '#find' do
    subject { metadata.find }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('get /customer/{id}') }
  end

  describe '#http_methods' do
    subject { metadata.http_methods }

    before { stub_customer_metadata }

    it { expect(subject.count).to eq(13) }
  end

  describe '#index' do
    subject { metadata.index }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('get /customer') }
  end

  describe '#patch' do
    subject { metadata.patch }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('patch /customer/{id}') }
  end

  describe '#properties' do
    subject { metadata.properties }

    before { stub_customer_metadata }

    it { expect(subject).to be_an(Array) }
    it { expect(subject.count).to eq(73) }
  end

  describe '#record' do
    subject { metadata.record }

    it { expect(subject).to eq(record) }
  end

  describe '#show' do
    subject { metadata.show }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('get /customer/{id}') }
  end

  describe '#update' do
    subject { metadata.update }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('patch /customer/{id}') }
  end

  describe '#upsert' do
    subject { metadata.upsert }

    before { stub_customer_metadata }

    it { expect(subject).to be_a(LedgerSync::Ledgers::NetSuite::Record::HTTPMethod) }
    it { expect(subject.key).to eq('put /customer/{id}') }
  end
end

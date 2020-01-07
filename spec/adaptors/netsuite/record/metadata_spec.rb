# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Record::Metadata, vcr: true do
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor }
  let(:metadata) do
    described_class.new(
      adaptor: adaptor,
      record: record
    )
  end

  before do
    allow_any_instance_of(LedgerSync::Adaptors::NetSuite::Token).to receive(:signature) { 'SIGNATURE' }
    allow_any_instance_of(LedgerSync::Adaptors::NetSuite::Token).to receive(:nonce) { 'NONCE' }
    allow_any_instance_of(LedgerSync::Adaptors::NetSuite::Token).to receive(:timestamp) { '1234567890' }
  end

  context 'when record=customer' do
    let(:record) { :customer }

    describe '#http_methods' do
      subject { metadata.http_methods }

      it { expect(subject.count).to eq(6) }
    end

    describe '#properties' do
      subject { metadata.properties }

      it { expect(subject.count).to eq(99) }
    end

    describe '#record' do
      subject { metadata.record }

      it { expect(subject).to eq(record) }
    end
  end
end

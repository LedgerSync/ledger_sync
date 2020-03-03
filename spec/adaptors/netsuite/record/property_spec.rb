# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Record::Property do
  let(:enum) do
    %w[
      AUTO
      OFF
      ON
    ]
  end
  let(:format) { nil }
  let(:key) { 'creditholdoverride' }
  let(:title) { 'Credit Hold' }
  let(:type) { 'string' }
  let(:property) do
    described_class.new(
      enum: enum,
      format: format,
      key: key,
      title: title,
      type: type
    )
  end

  describe '.new_from_hash' do
    let(:enum) do
      %w[
        PR
        PS
        PT
      ]
    end
    let(:key) { 'thirdPartyCountry' }
    let(:format) { nil }
    let(:type) { 'string' }
    let(:title) { '3rd Party Billing Country' }
    let(:property) do
      described_class.new_from_hash(
        {
          key: key,
          "title": title,
          "type": type,
          "nullable": true,
          "enum": enum
        }
      )
    end

    describe '#enum' do
      subject { property.enum }

      it { expect(subject).to eq(enum) }
    end

    describe '#format' do
      subject { property.format }

      it { expect(subject).to eq(format) }
    end

    describe '#key' do
      subject { property.key }

      it { expect(subject).to eq(key) }
    end

    describe '#title' do
      subject { property.title }

      it { expect(subject).to eq(title) }
    end

    describe '#type' do
      subject { property.type }

      it { expect(subject).to eq(type) }
    end
  end
end

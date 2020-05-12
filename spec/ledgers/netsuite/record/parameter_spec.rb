# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Record::Parameter do
  let(:enum) { :asdf }
  let(:format) { :asdf }
  let(:key) { :asdf }
  let(:title) { :asdf }
  let(:type) { :asdf }
  let(:parameter) do
    described_class.new(
      enum: enum,
      format: format,
      key: key,
      title: title,
      type: type
    )
  end

  describe '.new_from_hash' do
    let(:name) { 'q' }
    let(:location) { 'query' }
    let(:description) { 'Search query used to filter results' }
    let(:required) { false }
    let(:schema) do
      {
        'type' => 'string'
      }
    end
    let(:parameter) do
      described_class.new_from_hash(
        {
          'name' => name,
          'in' => location,
          'description' => description,
          'required' => required,
          'schema' => schema
        }
      )
    end

    describe '#name' do
      subject { parameter.name }

      it { expect(subject).to eq(name) }
    end

    describe '#location' do
      subject { parameter.location }

      it { expect(subject).to eq(location) }
    end

    describe '#description' do
      subject { parameter.description }

      it { expect(subject).to eq(description) }
    end

    describe '#required' do
      subject { parameter.required }

      it { expect(subject).to eq(required) }
    end

    describe '#schema' do
      subject { parameter.schema }

      it { expect(subject).to eq(schema) }
    end
  end
end

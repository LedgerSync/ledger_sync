# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Record::HTTPMethod do
  let(:data) { :asdf }
  let(:method) { :asdf }
  let(:parameters) { :asdf }
  let(:path) { :asdf }
  let(:summary) { :asdf }
  let(:property) do
    described_class.new(
      data: data,
      method: method,
      parameters: parameters,
      path: path,
      summary: summary
    )
  end

  describe '.new_from_hash' do
    let(:method) { 'get' }
    let(:parameters) do
      [
        {
          'name' => 'q',
          'in' => 'query',
          'description' => 'Search query used to filter results',
          'required' => false,
          'schema' => {
            'type' => 'string'
          }
        }
      ]
    end
    let(:path) { '/customer' }
    let(:summary) { 'Get list of records' }
    let(:data) do
      {
        'tags' => [
          'customer'
        ],
        'summary' => summary,
        'parameters' => parameters,
        'responses' => {
          '200' => {
            'description' => 'Get record',
            'content' => {
              'application/vnd.oracle.resource+json; type=collection' => {
                'schema' => {
                  '$ref' => '#/components/schemas/customerCollection'
                }
              }
            }
          },
          'default' => {
            'description' => 'Error response.',
            'content' => {
              'application/vnd.oracle.resource+json; type=error' => {
                'schema' => {
                  '$ref' => '#/components/schemas/x-ns-error'
                }
              }
            }
          }
        }
      }
    end
    let(:property) do
      described_class.new_from_hash(
        data: data,
        method: method,
        path: path
      )
    end

    describe '#method' do
      subject { property.method }

      it { expect(subject).to eq(method) }
    end

    describe '#parameters' do
      subject { property.parameters }

      it { expect(subject).to eq(parameters) }
    end

    describe '#parameters' do
      subject { property.parameters }

      it { expect(subject).to eq(parameters) }
    end

    describe '#path' do
      subject { property.path }

      it { expect(subject).to eq(path) }
    end

    describe '#raw' do
      subject { property.raw }

      it { expect(subject).to eq(data) }
    end

    describe '#summary' do
      subject { property.summary }

      it { expect(subject).to eq(summary) }
    end
  end
end

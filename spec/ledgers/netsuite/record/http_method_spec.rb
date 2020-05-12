# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Record::HTTPMethod do
  let(:data) { :asdf }
  let(:method) { :asdf }
  let(:parameters) { :asdf }
  let(:path) { :asdf }
  let(:summary) { :asdf }
  let(:property) do
    described_class.new(
      data.merge(
        method: method,
        parameters: parameters,
        path: path
      )
    )
  end

  describe '.new_from_hash' do
    let(:method) { 'get' }
    let(:path) { '/customer' }
    let(:summary) { 'Get list of records.' }
    let(:data) do
      {
        "tags": [
          'Customer (Beta)'
        ],
        "summary": 'Get list of records.',
        "parameters": [
          {
            "name": 'q',
            "in": 'query',
            "description": 'Search query used to filter results',
            "required": false,
            "schema": {
              "type": 'string'
            }
          },
          {
            "name": 'limit',
            "in": 'query',
            "description": 'The limit used to specify the number of results on a single page.',
            "required": false,
            "schema": {
              "type": 'integer',
              "default": 1000
            }
          },
          {
            "name": 'offset',
            "in": 'query',
            "description": 'The offset used for selecting a specific page of results.',
            "required": false,
            "schema": {
              "type": 'integer',
              "default": 0
            }
          }
        ],
        "responses": {
          "200": {
            "description": 'List of records.',
            "content": {
              "application/vnd.oracle.resource+json; type=collection": {
                "schema": {
                  "$ref": '#/components/schemas/customerCollection'
                }
              }
            }
          },
          "default": {
            "description": 'Error response.',
            "content": {
              "application/vnd.oracle.resource+json; type=error": {
                "schema": {
                  "$ref": '#/components/schemas/nsError'
                }
              }
            }
          }
        }
      }
    end

    let(:http_method) do
      described_class.new_from_hash(
        data.merge(
          method: method,
          path: path
        )
      )
    end

    describe '#method' do
      subject { http_method.method }

      it { expect(subject).to eq(method) }
    end

    describe '#parameters' do
      subject { http_method.parameters }

      it { expect(subject.first).to be_a(LedgerSync::Ledgers::NetSuite::Record::Parameter) }
    end

    describe '#path' do
      subject { http_method.path }

      it { expect(subject).to eq(path) }
    end

    describe '#summary' do
      subject { http_method.summary }

      it { expect(subject).to eq(summary) }
    end
  end
end

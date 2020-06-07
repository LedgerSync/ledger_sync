# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Ledgers::NetSuite::Subsidiary::Searcher do
  include NetSuiteHelpers

  describe 'default behavior' do
    it_behaves_like 'a netsuite searcher'
  end

  describe 'subsidiaries not enabled case' do
    body = {
      "type": 'https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.1',
      "title": 'Invalid search query Search error occurred: Record ‘subsidiary’ was not found..',
      "status": 400,
      "o:errorCode": 'INVALID_PARAMETER'
    }

    let(:client) { netsuite_client }

    let(:input) do
      {
        client: client,
        query: ''
      }
    end

    subject { described_class.new(**input) }

    before do
      stub_request(
        :post,
        subject.request_url
      ).to_return(status: 400, body: body.to_json)
    end

    it { expect { subject.resources }.to raise_error(LedgerSync::Ledgers::NetSuite::Error::SubsidiariesNotEnabled) }
  end
end

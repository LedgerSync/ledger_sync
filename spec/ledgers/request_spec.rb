# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::Request do
  let(:body) { { 'body_foo' => 'body_bar' } }
  let(:headers) { { 'header_foo' => 'header_bar' } }
  let(:method) { :post }
  let(:params) { { 'param_foo' => 'param_bar' } }
  let(:url) { 'http://example.com/' }

  let(:arguments) do
    {
      body: body,
      headers: headers,
      method: method,
      params: params,
      url: url
    }
  end
  let(:request) { described_class.new(**arguments) }

  subject { request }

  before do
    stub_request(:post, 'http://example.com/?param_foo=param_bar')
      .with(
        body: { '{"body_foo":"body_bar"}' => nil },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Header-Foo' => 'header_bar',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end

  describe '#perform' do
    subject { request.perform }

    it do
      expect(subject).to be_a(LedgerSync::Ledgers::Response)
    end
  end

  describe '#performed?' do
    subject { request.performed? }

    it do
      expect(subject).to be_falsey
      request.perform
      expect(request.performed?).to be_truthy
    end
  end
end

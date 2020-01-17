# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Request do
  include QuickBooksOnlineHelpers

  let(:adaptor) { quickbooks_online_adaptor }
  let(:url) { 'https://www.example.com' }
  let(:method) { 'post' }
  let(:headers) { {} }
  let(:new_oauth_token) do
    OAuth2::AccessToken.new(
      adaptor.oauth_client,
      'asdf'
    )
  end
  let(:oauth_error) do
    OAuth2::Error.new(
      OpenStruct.new
    )
  end
  let(:auth_error) do
    LedgerSync::Error::AdaptorError::AuthenticationError.new(
      adaptor: adaptor,
      message: 'foo'
    )
  end

  let(:request) do
    described_class.new(
      adaptor: adaptor,
      headers: headers,
      method: method,
      url: url
    )
  end

  def stub
    stub_request(:post, 'https://www.example.com/')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => /Bearer .*/,
          'Content-Length' => '0',
          'User-Agent' => 'Faraday v0.17.1'
        }
      )
      .to_return(status: 200, body: '{}', headers: {})
  end

  def stub_refresh
    stub_request(:post, 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer')
      .with(
        body: { 'client_id' => 'client_id', 'client_secret' => 'client_secret', 'grant_type' => 'refresh_token', 'refresh_token' => 'refresh_token' },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'Faraday v0.17.1'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end

  describe '#perform' do
    it 'returns response' do
      stub
      expect(request.perform).to be_a(LedgerSync::Adaptors::Response)
    end

    it 'throws generic error' do
      allow(request).to receive(:oauth) { raise oauth_error }
      expect { request.perform }.to raise_error(LedgerSync::Error::OperationError)
    end

    it 'refreshes' do
      stub
      allow(request).to receive(:oauth).and_wrap_original do |m, *args|
        if @after_first_pass
          m.call(*args)
        else
          @after_first_pass = true
          raise OAuth2::Error, OpenStruct.new
        end
      end
      allow(request).to receive(:parse_error).once.and_return(
        auth_error
      )
      expect_any_instance_of(described_class).to receive(:refresh!).once.and_return(
        new_oauth_token
      )
      expect(request.perform).to be_a(LedgerSync::Adaptors::Response)
    end

    it 'refreshes and parses error' do
      allow(request).to receive(:oauth).and_wrap_original do |m, *args|
        raise OAuth2::Error, OpenStruct.new
      end
      allow(request).to receive(:parse_error).twice.and_return(
        auth_error
      )
      expect_any_instance_of(described_class).to receive(:refresh!).once.and_return(
        new_oauth_token
      )
      expect { request.perform }.to raise_error(auth_error.class)
    end
  end

  describe '#refresh!' do
    it do
      expect_any_instance_of(OAuth2::AccessToken).to receive(:refresh!).once.and_return(
        new_oauth_token
      )
      request.refresh!
    end

    it do
      allow_any_instance_of(OAuth2::AccessToken).to receive(:refresh!) do
        raise oauth_error
      end
      expect { request.refresh! }.to raise_error(LedgerSync::Error::OperationError)
    end
  end
end

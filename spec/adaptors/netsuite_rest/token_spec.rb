# frozen_string_literal: true

require 'spec_helper'

# Ref: https://5743578-sb1.app.netsuite.com/app/help/helpcenter.nl?fid=section_1534941088.html
RSpec.describe LedgerSync::Adaptors::NetSuiteREST::Token do
  let(:expected_signature_data_string) { 'POST&https%3A%2F%2F1234567.restlets.api.netsuite.com%2Fapp%2Fsite%2Fhosting%2Frestlet.nl&customParam%3DsomeValue%26deploy%3D1%26oauth_consumer_key%3Def40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4%26oauth_nonce%3DfjaLirsIcCGVZWzBX0pg%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D1508242306%26oauth_token%3D2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc%26oauth_version%3D1.0%26script%3D6%26testParam%3DsomeOtherValue' }

  let(:account_id) { '1234567' }
  let(:consumer_key) { 'ef40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4' }
  let(:consumer_secret) { 'd26ad321a4b2f23b0741c8d38392ce01c3e23e109df6c96eac6d099e9ab9e8b5' }
  let(:http_method) { 'POST' }
  let(:nonce) { 'fjaLirsIcCGVZWzBX0pg' }
  let(:token_id) { '2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc' }
  let(:token_secret) { 'c29a677df7d5439a458c063654187e3d678d73aca8e3c9d8bea1478a3eb0d295' }
  let(:timestamp) { '1508242306' }
  let(:url) { 'https://1234567.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=6&deploy=1&customParam=someValue&testParam=someOtherValue' }

  let(:token) do
    described_class.new(
      account_id: account_id,
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      http_method: http_method,
      nonce: nonce,
      token_id: token_id,
      token_secret: token_secret,
      timestamp: timestamp,
      url: url
    )
  end

  describe '#signature' do
    it do
      allow(token).to receive(:signature_data_string) { expected_signature_data_string }
      expect(token.signature).to eq('he6PiRPNQnRlrUOwFB6zzHBcHOYLBulKXn9WIWHsjhc')
    end

    it do
      expect(token.signature).to eq('he6PiRPNQnRlrUOwFB6zzHBcHOYLBulKXn9WIWHsjhc')
    end
  end

  describe '#signature_data_string' do
    it do
      expect(token.signature_data_string).to eq(expected_signature_data_string)
    end
  end

  describe '#signature_key' do
    it do
      expect(token.signature_key).to eq("#{consumer_secret}&#{token_secret}")
    end
  end
end

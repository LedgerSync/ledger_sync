# frozen_string_literal: true

require 'spec_helper'
require 'adaptors/quickbooks_online/shared_examples'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Webhook do
  include QuickBooksOnlineHelpers

  let(:payload) { webhook_hash }
  let(:instance) { described_class.new(payload: payload) }

  it_behaves_like 'webhook payloads'

  describe '#notifications' do
    it { expect(instance.notifications.count).to eq(2) }
  end

  describe '#valid?' do
    it do
      args = {
        signature: 'test_signature',
        verification_token: 'test_verification_token'
      }
      expect(described_class).to receive(:valid?).with(**args.merge(payload: payload.to_json))
      instance.valid?(**args)
    end
  end

  describe '.valid?' do
    let(:args) do
      verification_token = 'asdf'

      payload = payload.to_json

      digest = OpenSSL::Digest.new('sha256')
      hmac = OpenSSL::HMAC.digest(digest, verification_token, payload)
      base64 = Base64.encode64(hmac).strip

      {
        payload: payload,
        signature: base64,
        verification_token: verification_token
      }
    end

    it { expect(described_class.valid?(**args)).to be_truthy }

    it do
      args.merge!(signature: 'foo')
      expect(described_class.valid?(**args)).to be_falsey
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Adaptor do
  include QuickBooksHelpers

  let(:access_token) { 'access_token' }
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:expires_at) { nil }
  let(:realm_id) { 'realm_id' }
  let(:refresh_token) { 'refresh_token' }
  let(:refresh_token_expires_at) { nil }
  let(:test) { true }

  subject do
    described_class.new(
      access_token: access_token,
      client_id: client_id,
      client_secret: client_secret,
      realm_id: realm_id,
      refresh_token: refresh_token,
      test: test
    )
  end

  describe '#find' do
    it { expect(subject).to respond_to(:find) }
  end

  describe '#ledger_attributes_to_save' do
    it do
      h = {
        access_token: access_token,
        expires_at: expires_at,
        refresh_token_expires_at: nil,
        refresh_token: refresh_token

      }
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  describe '#post' do
    it { expect(subject).to respond_to(:post) }
  end

  describe '#query' do
    it { expect(subject).to respond_to(:query) }
  end

  describe '#refresh!' do
    it { expect(subject).to respond_to(:refresh!) }
    it do
      stub_adaptor_refresh
      expect(subject.expires_at).to be_nil
      expect(subject.refresh_token_expires_at).to be_nil
      subject.refresh!
      expect(subject.expires_at).to be_a(DateTime)
      expect(subject.refresh_token_expires_at).to be_a(DateTime)
    end
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[access_token expires_at refresh_token refresh_token_expires_at]) }
  end
end

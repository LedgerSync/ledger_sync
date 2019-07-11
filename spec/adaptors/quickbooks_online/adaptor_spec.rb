require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Adaptor do
  let(:access_token) { 'access_token' }
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:expires_at) { nil }
  let(:realm_id) { 'realm_id' }
  let(:refresh_token) { 'refresh_token' }
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
        refresh_token: refresh_token

      }
      expect(subject.ledger_attributes_to_save).to eq(h)
    end
  end

  describe '#query' do
    it { expect(subject).to respond_to(:query) }
  end

  describe '#upsert' do
    it { expect(subject).to respond_to(:upsert) }
  end

  describe '.ledger_attributes_to_save' do
    subject { described_class.ledger_attributes_to_save }

    it { expect(subject).to eq(%i[access_token expires_at refresh_token]) }
  end
end

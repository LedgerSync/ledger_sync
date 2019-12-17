# frozen_string_literal: true

require 'spec_helper'
require 'adaptors/quickbooks_online/shared_examples'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::WebhookNotification do
  include QuickBooksOnlineHelpers

  let(:payload) { webhook_notification_hash(realm_id: 'realm_1') }
  let(:instance) { described_class.new(payload: payload) }

  it_behaves_like 'webhook payloads'

  describe '#events' do
    it { expect(instance.events.count).to eq(2) }
  end

  describe '#realm_id' do
    it { expect(instance.realm_id).to eq('realm_1') }
    it do
      payload.delete('realmId')
      expect { instance }.to raise_error(RuntimeError)
    end
  end
end

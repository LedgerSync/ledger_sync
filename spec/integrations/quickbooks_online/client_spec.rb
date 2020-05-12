# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/client', type: :feature do
  include QuickBooksOnlineHelpers

  before do
    stub_client_refresh
  end

  let(:client) { quickbooks_online_client }

  context '#refresh' do
    subject { client.refresh! }

    it { expect(subject.access_token).not_to eq(quickbooks_online_client.access_token) }
    it { expect(subject.refresh_token).not_to eq(quickbooks_online_client.refresh_token) }
    it { expect(subject.access_token).to eq('NEW_ACCESS_TOKEN') }
    it { expect(subject.refresh_token).to eq('NEW_REFRESH_TOKEN') }
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/connection', type: :feature do
  include QuickBooksOnlineHelpers

  before do
    stub_connection_refresh
  end

  let(:connection) { quickbooks_online_connection }

  context '#refresh' do
    subject { connection.refresh! }

    it { expect(subject.access_token).not_to eq(quickbooks_online_connection.access_token) }
    it { expect(subject.refresh_token).not_to eq(quickbooks_online_connection.refresh_token) }
    it { expect(subject.access_token).to eq('NEW_ACCESS_TOKEN') }
    it { expect(subject.refresh_token).to eq('NEW_REFRESH_TOKEN') }
  end
end

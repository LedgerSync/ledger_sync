# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/adaptor', type: :feature do
  include QuickBooksOnlineHelpers

  before do
    stub_adaptor_refresh
  end

  let(:adaptor) { quickbooks_online_adaptor }

  context '#refresh' do
    subject { adaptor.refresh! }

    it { expect(subject.access_token).not_to eq(quickbooks_online_adaptor.access_token) }
    it { expect(subject.refresh_token).not_to eq(quickbooks_online_adaptor.refresh_token) }
    it { expect(subject.access_token).to eq('NEW_ACCESS_TOKEN') }
    it { expect(subject.refresh_token).to eq('NEW_REFRESH_TOKEN') }
  end
end

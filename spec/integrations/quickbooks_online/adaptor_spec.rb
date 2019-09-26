require 'spec_helper'

support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/adaptor', type: :feature do
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_adaptor_refresh
  }

  let(:adaptor) { quickbooks_adaptor }

  context '#refresh' do
    subject { adaptor.refresh! }
    it { expect(subject.access_token).not_to eq(quickbooks_adaptor.access_token) }
    it { expect(subject.refresh_token).not_to eq(quickbooks_adaptor.refresh_token) }
    it { expect(subject.access_token).to eq('NEW_ACCESS_TOKEN') }
    it { expect(subject.refresh_token).to eq('NEW_REFRESH_TOKEN') }
  end
end

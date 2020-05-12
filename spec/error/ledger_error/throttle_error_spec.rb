# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Error::LedgerError::ThrottleError do
  include QuickBooksOnlineHelpers

  let(:error) { described_class.new(client: quickbooks_online_client) }

  it { expect(error.rate_limiting_wait_in_seconds).to eq(60) }
end

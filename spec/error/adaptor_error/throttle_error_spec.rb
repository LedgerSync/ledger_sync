# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Error::AdaptorError::ThrottleError do
  include QuickBooksOnlineHelpers

  let(:error) { described_class.new(adaptor: quickbooks_online_adaptor) }

  it { expect(error.rate_limiting_wait_in_seconds).to eq(60) }
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Error::LedgerError::ThrottleError do
  let(:error) { described_class.new(client: test_ledger_client) }

  it { expect(error.rate_limiting_wait_in_seconds).to eq(60) }
end

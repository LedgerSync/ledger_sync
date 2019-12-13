# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Error::AdaptorError::ThrottleError do
  include TestAdaptorHelpers

  let(:error) { described_class.new(adaptor: test_adaptor) }

  it { expect(error.rate_limiting_wait_in_seconds).to eq(47) }
end

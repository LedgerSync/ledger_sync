require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Error::AdaptorError::ThrottleError do
  include AdaptorHelpers

  let(:error) { described_class.new(adaptor: test_adaptor) }

  it { expect(error.rate_limiting_wait_in_seconds).to eq(47) }
end

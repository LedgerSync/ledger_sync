require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Error::AdaptorError::Operations::ThrottleError do
  include AdaptorHelpers

  let(:error) { LedgerSync::Error::AdaptorError::ThrottleError.new(adaptor: test_adaptor) }
  let(:op) do
    described_class.new(
      adaptor: test_adaptor,
      resource: error
    )
  end

  let(:result) { op.perform }

  it { expect(result).to be_failure }
  it { expect(result.error).to be_a(LedgerSync::Error::AdaptorError::ThrottleError) }
end

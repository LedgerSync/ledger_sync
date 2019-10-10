require 'spec_helper'

support 'adaptor_helpers'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Util::AdaptorErrorParser do
  include AdaptorHelpers

  let(:message) { 'This is the error message.' }
  let(:error) { StandardError.new(message) }
  let(:adaptor) { quickbooks_adaptor }
  let(:parser) do
    described_class.new(
      adaptor: adaptor,
      error: error
    )
  end

  let(:result) { parser.parse }

  it do
    allow_any_instance_of(described_class::ThrottleMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::AdaptorError::ThrottleError)
  end

  it do
    allow_any_instance_of(described_class::AuthenticationMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::AdaptorError::AuthenticationError)
  end

  it do
    allow_any_instance_of(described_class::AuthorizationMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::AdaptorError::AuthorizationError)
  end

  it do
    allow_any_instance_of(described_class::ClientMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::AdaptorError::ConfigurationError)
  end
end

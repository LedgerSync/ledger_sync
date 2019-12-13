# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Util::AdaptorErrorParser do
  include QuickBooksOnlineHelpers

  let(:message) { 'This is the error message.' }
  let(:error) { StandardError.new(message) }
  let(:adaptor) { quickbooks_online_adaptor }
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

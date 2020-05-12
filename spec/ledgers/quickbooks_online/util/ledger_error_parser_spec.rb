# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Util::LedgerErrorParser do
  include QuickBooksOnlineHelpers

  let(:message) { 'This is the error message.' }
  let(:error) { StandardError.new(message) }
  let(:client) { quickbooks_online_client }
  let(:parser) do
    described_class.new(
      client: client,
      error: error
    )
  end

  let(:result) { parser.parse }

  it do
    allow_any_instance_of(described_class::ThrottleMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::LedgerError::ThrottleError)
  end

  it do
    allow_any_instance_of(described_class::AuthenticationMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::LedgerError::AuthenticationError)
  end

  it do
    allow_any_instance_of(described_class::AuthorizationMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::LedgerError::AuthorizationError)
  end

  it do
    allow_any_instance_of(described_class::ClientMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::LedgerError::ConfigurationError)
  end
end

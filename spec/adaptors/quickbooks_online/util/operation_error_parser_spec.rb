require 'spec_helper'

support 'adaptor_helpers'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Util::OperationErrorParser do
  include AdaptorHelpers

  let(:message) { 'This is the error message.' }
  let(:error) { StandardError.new(message) }
  let(:operation) do
    LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create.new(
      adaptor: quickbooks_adaptor,
      resource: LedgerSync::Customer.new
    )
  end
  let(:parser) do
    described_class.new(
      error: error,
      operation: operation
    )
  end

  let(:result) { parser.parse }

  it do
    allow_any_instance_of(described_class::DuplicateNameMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::OperationError::DuplicateLedgerResourceError)
  end

  it do
    allow_any_instance_of(described_class::NotFoundMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::OperationError::NotFoundError)
  end

  it do
    allow_any_instance_of(described_class::ValidationError).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::OperationError::LedgerValidationError)
  end

  it do
    allow_any_instance_of(described_class::GenericMatcher).to receive(:match?) { true }
    expect(result).to be_a(LedgerSync::Error::OperationError)
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Util::Performer do
  include TestAdaptorHelpers

  let(:valid_operation) { LedgerSync::Adaptors::Test::Customer::Operations::Valid.new(adaptor: test_adaptor, resource: resource) }
  let(:invalid_operation) { LedgerSync::Adaptors::Test::Customer::Operations::Invalid.new(adaptor: test_adaptor, resource: resource) }
  let(:resource) { LedgerSync::Customer.new(external_id: 123) }

  it do
    operations = [
      valid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::Result::Success)
  end

  it do
    operations = [
      valid_operation,
      invalid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::ValidationResult::Failure)
  end

  it do
    operations = [
      invalid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::ValidationResult::Failure)
  end
end

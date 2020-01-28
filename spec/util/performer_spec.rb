# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Util::Performer do
  include NetSuiteHelpers

  let(:resource) { LedgerSync::Customer.new(external_id: 123) }
  let(:valid_operation) { LedgerSync::Adaptors::NetSuite::Customer::Operations::Valid.new(adaptor: netsuite_adaptor, resource: resource) }
  let(:invalid_operation) { LedgerSync::Adaptors::NetSuite::Customer::Operations::Invalid.new(adaptor: netsuite_adaptor, resource: resource) }

  it do
    skip 'rewrite when you can override validation_contract'
    operations = [
      valid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::Result::Success)
  end

  it do
    skip 'rewrite when you can override validation_contract'
    operations = [
      valid_operation,
      invalid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::ValidationResult::Failure)
  end

  it do
    skip 'rewrite when you can override validation_contract'
    operations = [
      invalid_operation
    ]
    expect(described_class.new(operations: operations).perform).to be_a(LedgerSync::ValidationResult::Failure)
  end
end

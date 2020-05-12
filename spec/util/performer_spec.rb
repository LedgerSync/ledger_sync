# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Util::Performer do
  include NetSuiteHelpers

  let(:resource) { LedgerSync::Customer.new(external_id: 123) }
  let(:valid_contract) do
    Class.new(LedgerSync::Ledgers::Contract) do
      params do
        required(:external_id).filled(:string)
      end
    end
  end

  let(:invalid_contract) do
    Class.new(LedgerSync::Ledgers::Contract) do
      params do
        required(:external_id).filled(:nil)
      end
    end
  end

  let(:valid_operation) do
    LedgerSync::Ledgers::NetSuite::Customer::Operations::Create.new(
      client: netsuite_client,
      resource: resource,
      validation_contract: valid_contract
    )
  end

  let(:invalid_operation) do
    LedgerSync::Ledgers::NetSuite::Customer::Operations::Create.new(
      client: netsuite_client,
      resource: resource,
      validation_contract: invalid_contract
    )
  end

  it do
    allow(valid_operation).to receive(:perform) do
      LedgerSync::OperationResult::Success.new(
        nil,
        operation: nil,
        resource: nil,
        response: nil
      )
    end

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

# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::Operation do
  include NetSuiteHelpers

  let(:client) { netsuite_client }
  let(:resource) { FactoryBot.create(:customer) }
  let(:operation_class) { client.base_module::Customer::Operations::Create }
  let(:serializer_class) do
    Class.new(LedgerSync::Ledgers::LedgerSerializer) do
      attribute ledger_attribute: :foo,
                resource_attribute: :foo
    end
  end
  let(:validation_contract) do
    Class.new(LedgerSync::Ledgers::Contract) do
      params do
        required(:foo).filled(:string)
      end
    end
  end
  let(:custom_resource_class) do
    class_name = "#{test_run_id}TestCustomResource"
    Object.const_get(class_name)
  rescue NameError
    Object.const_set(
      class_name,
      Class.new(LedgerSync::Customer) do
        attribute :foo, type: LedgerSync::Type::String
      end
    )
  end
  let(:operation) do
    operation_class.new(
      client: client,
      resource: resource
    )
  end

  subject { operation }

  it { expect { described_class.new }.to raise_error(NoMethodError) } # Operation is a module

  describe '#failure?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).not_to be_failure
    end
  end

  describe '#deserializer' do
    it do
      op = operation_class.new(
        client: netsuite_client,
        resource: FactoryBot.create(:customer)
      )
      expect(op.deserializer).to be_a(LedgerSync::Ledgers::NetSuite::Customer::Deserializer)
    end
  end

  describe '#perform' do
    subject { operation.perform }

    it do
      stub_customer_create
      stub_customer_find
      expect(subject).to be_success
    end

    it do
      allow(operation).to receive(:operate) { raise LedgerSync::Error.new(message: 'Test') }
      expect(subject).to be_failure
      expect(subject.error.message).to eq('Test')
    end
  end

  describe '#resource' do
    it do
      op = operation_class.new(
        client: netsuite_client,
        resource: FactoryBot.create(:customer)
      )
      expect(op.resource).to be_a(LedgerSync::Customer)
    end

    it do
      op = operation_class.new(
        client: netsuite_client,
        resource: custom_resource_class.new
      )
      expect(op.resource).to be_a(custom_resource_class)
    end

    it do
      expect do
        operation_class.new(
          client: netsuite_client,
          resource: FactoryBot.create(:expense)
        )
      end.to raise_error(LedgerSync::Error::UnexpectedClassError)
    end

    it do
      expect do
        operation_class.new(
          client: netsuite_client,
          resource: nil
        )
      end.to raise_error(LedgerSync::Error::UnexpectedClassError)
    end
  end

  describe '#serializer' do
    it do
      op = operation_class.new(
        client: netsuite_client,
        resource: FactoryBot.create(:customer)
      )
      expect(op.serializer).to be_a(LedgerSync::Ledgers::NetSuite::Customer::Serializer)
    end
  end

  describe '#success?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).to be_success
    end
  end

  describe '#valid?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).not_to be_valid
    end
  end

  describe '#validation_contract' do
    it do
      op = operation_class.new(
        client: netsuite_client,
        resource: FactoryBot.create(:customer)
      )
      expect(op.validation_contract).to eq(operation_class::Contract)
    end

    it do
      op = operation_class.new(
        client: netsuite_client,
        validation_contract: nil,
        resource: FactoryBot.create(:customer)
      )
      expect(op.validation_contract).to eq(operation_class::Contract)
    end

    it do
      op = operation_class.new(
        client: netsuite_client,
        validation_contract: validation_contract,
        resource: FactoryBot.create(:customer)
      )
      expect(op.validation_contract).to eq(validation_contract)
    end

    it do
      expect do
        operation_class.new(
          client: netsuite_client,
          validation_contract: 'asdf',
          resource: FactoryBot.create(:customer)
        )
      end.to raise_error(LedgerSync::Error::UnexpectedClassError)
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::Operation do
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor }
  let(:resource) { FactoryBot.create(:customer) }
  let(:operation_class) { adaptor.base_module::Customer::Operations::Create }
  let(:serializer_class) do
    Class.new(LedgerSync::Adaptors::LedgerSerializer) do
      attribute ledger_attribute: :foo,
                resource_attribute: :foo
    end
  end
  let(:operation) do
    operation_class.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  subject { operation }

  it { expect { described_class.new }.to raise_error(NoMethodError) } # Operation is a module

  before do
    stub_customer_create
    stub_customer_find
  end

  subject { operation }

  it { expect { described_class.new }.to raise_error(NoMethodError) } # Operation is a module

  describe '#failure?' do
    it do
      subject.perform
      expect(subject).not_to be_failure
    end
  end

  describe '#ledger_deserializer_class' do
    it do
      op = operation_class.new(
        adaptor: netsuite_adaptor,
        resource: FactoryBot.create(:customer)
      )
      expect(op.ledger_deserializer_class).to eq(LedgerSync::Adaptors::NetSuite::Customer::LedgerDeserializer)
    end

    it do
      op = operation_class.new(
        adaptor: netsuite_adaptor,
        ledger_deserializer_class: nil,
        resource: FactoryBot.create(:customer)
      )
      expect(op.ledger_deserializer_class).to eq(LedgerSync::Adaptors::NetSuite::Customer::LedgerDeserializer)
    end

    it do
      op = operation_class.new(
        adaptor: netsuite_adaptor,
        ledger_deserializer_class: serializer_class,
        resource: FactoryBot.create(:customer)
      )
      expect(op.ledger_deserializer_class).to eq(serializer_class)
    end

    it do
      expect do
        operation_class.new(
          adaptor: netsuite_adaptor,
          ledger_deserializer_class: 'asdf',
          resource: FactoryBot.create(:customer)
        )
      end.to raise_error(LedgerSync::Error::UnexpectedClassError)
    end
  end

  describe '#perform' do
    subject { operation.perform }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:operate) { raise LedgerSync::Error.new(message: 'Test') }
      expect(subject).to be_failure
      expect(subject.error.message).to eq('Test')
    end
  end

  describe '#success?' do
    it do
      subject.perform
      expect(subject).to be_success
    end
  end

  describe '#valid?' do
    it do
      subject.perform
      expect(subject).not_to be_valid
    end
  end
end

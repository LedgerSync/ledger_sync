# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::Client do
  let(:client) { test_ledger_client }
  let(:resource) { LedgerSync::Ledgers::TestLedger::Customer.new }

  subject { test_ledger_client }

  it { expect { described_class.new }.to raise_error(NoMethodError) }

  describe '#operation_for' do
    let(:operation_class) { LedgerSync::Ledgers::TestLedger::Customer::Operations::Create }
    it do
      method = :create

      expect(client.class).to(
        receive(:operation_class_for).once.with(method: method, resource_class: resource.class)
      ).and_return(operation_class)

      test_ledger_client.operation_for(
        method: method,
        resource: resource
      )
    end

    it do
      operation = client.operation_for(
        method: :create,
        resource: resource
      )

      expect(operation).to be_a(operation_class)
      expect(operation.resource).to eq(resource)
      expect(operation.client).to eq(client)
    end
  end

  describe '#searcher_for' do
    it do
      searcher = subject.searcher_for(resource_type: :customer)
      expect(searcher).to be_a(LedgerSync::Ledgers::TestLedger::Customer::Searcher)
    end
    it do
      expect { subject.searcher_for(resource_type: :asdf) }.to raise_error(
        NameError, 'uninitialized constant LedgerSync::Ledgers::TestLedger::Asdf'
      )
    end
  end

  describe '#searcher_class_for' do
    it do
      searcher = subject.searcher_class_for(resource_type: :customer)
      expect(searcher).to eq(LedgerSync::Ledgers::TestLedger::Customer::Searcher)
    end
  end

  describe '.base_operations_module_for' do
    it do
      ret = client.class.base_operations_module_for(resource_class: resource.class)
      expect(ret).to eq(LedgerSync::Ledgers::TestLedger::Customer::Operations)
    end
  end

  describe '.ledger_attributes_to_save' do
    it { expect { described_class.ledger_attributes_to_save }.to raise_error(NoMethodError) }
    it do
      values = subject.class.ledger_attributes_to_save
      expect(values).to eq(%i[api_key])
    end
  end

  describe '.operation_class_for' do
    it do
      mod = LedgerSync::Ledgers::TestLedger::Customer::Operations

      ret = client.class.operation_class_for(method: :update, resource_class: resource.class)
      expect(ret).to eq(mod::Update)
    end
  end
end

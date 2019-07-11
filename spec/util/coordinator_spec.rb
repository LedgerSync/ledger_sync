require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Util::Coordinator do
  include AdaptorHelpers

  let(:test_create) { LedgerSync::Adaptors::Test::Customer::Operations::Create.new(adaptor: quickbooks_adaptor, resource: resource) }
  let(:test_upsert) { LedgerSync::Adaptors::Test::Customer::Operations::Upsert.new(adaptor: quickbooks_adaptor, resource: resource) }
  let(:test_update) { LedgerSync::Adaptors::Test::Customer::Operations::Update.new(adaptor: quickbooks_adaptor, resource: resource) }
  let(:resource) { LedgerSync::Customer.new(external_id: 123) }

  context '.convert_downstream_creates_to_upserts' do
    it do
      op1 = LedgerSync::Adaptors::Test::Customer::Operations::Create.new(adaptor: quickbooks_adaptor, resource: resource)
      op2 = LedgerSync::Adaptors::Test::Customer::Operations::Create.new(adaptor: quickbooks_adaptor, resource: resource)
      ops = described_class.convert_downstream_creates_to_upserts([op1, op2])
      expect(ops).to eq([op1, LedgerSync::Adaptors::Test::Customer::Operations::Update.new(adaptor: quickbooks_adaptor, resource: resource)])
    end
  end

  context '.de_dup' do
    it do
      op1 = LedgerSync::Adaptors::Test::Customer::Operations::Create.new(adaptor: quickbooks_adaptor, resource: resource)
      op2 = LedgerSync::Adaptors::Test::Customer::Operations::Create.new(adaptor: quickbooks_adaptor, resource: resource)
      ops = described_class.de_dup([op1, op2])
      expect(ops).to eq([op1])
    end
  end

  context '.flatten_operation' do
    let(:upsert_ops) { described_class.flatten_operation(test_upsert) }
    let(:create_ops) { described_class.flatten_operation(test_create) }

    it do
      expect(create_ops).to eq([test_create])
    end

    it do
      expect(upsert_ops).to eq([test_create])
    end

    it do
      allow(test_upsert).to receive(:customer_exists_in_ledger?) { true }
      expect(upsert_ops).to eq([test_update])
    end
  end
end

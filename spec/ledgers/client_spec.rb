# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::Client do
  include QuickBooksOnlineHelpers

  let(:client) { quickbooks_online_client }
  let(:resource) { FactoryBot.create(:customer) }

  subject { quickbooks_online_client }

  it { expect { described_class.new }.to raise_error(NotImplementedError) }

  describe '#operation_for' do
    let(:operation_class) { LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create }
    it do
      method = :create

      expect(client.class).to(
        receive(:operation_class_for).once.with(method: method, resource_class: resource.class)
      ).and_return(operation_class)

      quickbooks_online_client.operation_for(
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
    it { expect(subject.searcher_for(resource_type: :customer)).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Customer::Searcher) }
    it { expect { subject.searcher_for(resource_type: :asdf) }.to raise_error(NameError, 'uninitialized constant LedgerSync::Ledgers::QuickBooksOnline::Asdf') }
  end

  describe '#searcher_class_for' do
    it { expect(subject.searcher_class_for(resource_type: :customer)).to eq(LedgerSync::Ledgers::QuickBooksOnline::Customer::Searcher) }
  end

  describe '.base_operation_module_for' do
    it do
      expect(resource.class).to(
        receive(:resource_module_str).once
      ).and_return('Vendor')

      ret = client.class.base_operation_module_for(resource_class: resource.class)
      expect(ret).to eq(LedgerSync::Ledgers::QuickBooksOnline::Vendor::Operations)
    end

    it do
      expect(resource.class).to(
        receive(:resource_module_str).once
      ).and_return('Customer')

      ret = client.class.base_operation_module_for(resource_class: resource.class)
      expect(ret).to eq(LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations)
    end
  end

  describe '.ledger_attributes_to_save' do
    it { expect { described_class.ledger_attributes_to_save }.to raise_error(NotImplementedError) }
    it { expect(subject.class.ledger_attributes_to_save).to eq(%i[access_token expires_at refresh_token refresh_token_expires_at]) }
  end

  describe '.operation_class_for' do
    it do
      mod = LedgerSync::Ledgers::QuickBooksOnline::Account::Operations

      expect(client.class).to(
        receive(:base_operation_module_for).once.with(resource_class: resource.class)
      ).and_return(mod)

      ret = client.class.operation_class_for(method: :update, resource_class: resource.class)
      expect(ret).to eq(mod::Update)
    end
  end
end

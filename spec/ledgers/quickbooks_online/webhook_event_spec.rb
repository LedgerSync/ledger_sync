# frozen_string_literal: true

require 'spec_helper'
require 'ledgers/quickbooks_online/shared_examples'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::WebhookEvent do
  include QuickBooksOnlineHelpers

  let(:payload) { webhook_event_hash(quickbooks_online_resource_type: 'Customer') }

  let(:instance) do
    described_class.new(
      payload: payload,
      webhook_notification: webhook_notification
    )
  end

  it_behaves_like 'webhook payloads'

  describe '#deleted_id' do
    it { expect(instance.deleted_id).to be_nil }
    it do
      payload.merge!('deletedId' => 'asdf')
      expect(instance.deleted_id).to eq('asdf')
    end
  end

  describe '#event_operation' do
    it { expect(instance.event_operation).to eq('Create') }
    it do
      payload.delete('operation')
      expect { instance }.to raise_error(RuntimeError)
    end
  end

  describe '#find' do
    it 'finds customer' do
      stub_customer_find
      expect(instance.find(client: quickbooks_online_client)).to be_success
    end

    it 'finds vendor' do
      stub_vendor_find
      payload['name'] = 'Vendor'
      expect(instance.find(client: quickbooks_online_client)).to be_success
    end
  end

  describe '#find_operation' do
    it do
      op = instance.find_operation(client: quickbooks_online_client)
      expect(op).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Find)
    end
  end

  describe '#find_operation_class' do
    it do
      op = instance.find_operation_class(client: quickbooks_online_client)
      expect(op).to eq(LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Find)
    end
  end

  describe '#last_updated_at' do
    it { expect(instance.last_updated_at).to eq(Time.parse('2015-10-05T14:42:19-0700')) }
    it do
      payload.delete('lastUpdated')
      expect { instance }.to raise_error(RuntimeError)
    end
  end

  describe '#ledger_id' do
    it { expect(instance.ledger_id).to eq('123') }
    it do
      payload.delete('id')
      expect { instance }.to raise_error(RuntimeError)
    end
  end

  describe '#local_resource_type' do
    it { expect(instance.local_resource_type).to eq(:customer) }
    it do
      payload.merge!('name' => 'Vendor')
      expect(instance.local_resource_type).to eq(:vendor)
    end
  end

  describe '#quickbooks_online_resource_type' do
    it { expect(instance.quickbooks_online_resource_type).to eq('Customer') }
    it do
      payload.delete('name')
      expect { instance }.to raise_error(RuntimeError)
    end
  end

  describe '#resource' do
    it do
      expect(instance.resource).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Customer)
    end

    it do
      payload['name'] = 'Vendor'
      expect(instance.resource).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Vendor)
    end
  end

  describe '#resource!' do
    it do
      expect(instance.resource!).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Customer)
    end

    it do
      payload['name'] = 'ASDF'
      expect { instance.resource! }.to raise_error(RuntimeError)
    end
  end

  describe '#resource_class' do
    it { expect(instance.resource_class).to eq(LedgerSync::Ledgers::QuickBooksOnline::Customer) }
    it do
      payload.merge!('name' => 'Vendor')
      expect(instance.resource_class).to eq(LedgerSync::Ledgers::QuickBooksOnline::Vendor)
    end
  end
end

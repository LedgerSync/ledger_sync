# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  class TestResource
    class ResourceWithDate < LedgerSync::Resource
      attribute :date_attr, type: Type::Date
    end

    class TestUselessResource < LedgerSync::Resource
      references_one :test_useless_resource_attribute, to: LedgerSync::Resource
    end

    class TestGrandchildResource < LedgerSync::Resource
      references_one :useless_child, to: TestResource::TestUselessResource

      attribute :test_grandchild_resource_attribute, type: Type::String
    end

    class TestChildResource < LedgerSync::Resource
      references_one :grandchild, to: TestResource::TestGrandchildResource

      attribute :test_child_resource_attribute, type: Type::String
    end

    class TestParentResource < LedgerSync::Resource
      references_many :children, to: TestResource::TestChildResource

      attribute :test_parent_resource_attribute, type: Type::String
    end
  end
end

LedgerSync.register_resource(resource: LedgerSync::TestResource::ResourceWithDate)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestUselessResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestGrandchildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestChildResource)
LedgerSync.register_resource(resource: LedgerSync::TestResource::TestParentResource)

RSpec.describe LedgerSync::Util::ResourcesBuilder do
  context 'with date' do
    let(:data) do
      {
        resource_with_date: {
          date_resource_1: {
            data: {
              date_attr: '2019-01-01'
            }
          }
        }
      }
    end
    let(:root_resource_external_id) { :date_resource_1 }
    let(:root_resource_type) { :resource_with_date }

    let(:builder) do
      described_class.new(
        data: data,
        ledger: :root,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
    end
    let(:resource) { builder.resource }
    let(:resources) { builder.resources }

    it do
      expect(resource.date_attr).to be_a(Date)
    end

    it do
      data[:resource_with_date][:date_resource_1][:data][:date_attr] = 12_345
      builder = described_class.new(
        data: data,
        ledger: :root,
        cast: false,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
      expect(data[:resource_with_date][:date_resource_1][:data][:date_attr]).to eq(12_345)
      expect { builder.resource }.to raise_error(LedgerSync::ResourceAttributeError::TypeError)
    end
  end

  context 'with references' do
    let(:data) do
      {
        test_parent_resource: {
          test_parent_resource_external_id: {
            data: {
              children: %i[
                test_child_resource_external_id
                test_child2_resource_external_id
              ],
              test_parent_resource_attribute: 'test_parent_resource_value'
            }
          }
        },
        test_child_resource: {
          test_child_resource_external_id: {
            data: {
              grandchild: :test_grandchild_resource_external_id,
              test_child_resource_attribute: 'test_child_resource_value'
            }
          },
          test_child2_resource_external_id: {
            data: {
              test_child_resource_attribute: 'test_child2_resource_value'
            }
          }
        },
        test_grandchild_resource: {
          test_grandchild_resource_external_id: {
            data: {
              test_grandchild_resource_attribute: 'test_grandchild_resource_value'
            }
          }
        }
      }
    end

    let(:root_resource_external_id) { :test_parent_resource_external_id }
    let(:root_resource_type) { :test_parent_resource }

    let(:builder) do
      described_class.new(
        data: data,
        ledger: :root,
        root_resource_external_id: root_resource_external_id,
        root_resource_type: root_resource_type
      )
    end
    let(:resource) { builder.resource }
    let(:resources) { builder.resources }
    let(:parent) { resource }
    let(:child) { parent.children.first }
    let(:child2) { parent.children.last }
    let(:grandchild) { child.grandchild }

    it do
      expect(resource).to be_a(LedgerSync::TestResource::TestParentResource)
      expect(resources.count).to eq(4)

      expect(child).to be_a(LedgerSync::TestResource::TestChildResource)
      expect(child.external_id).to eq('test_child_resource_external_id')

      expect(child2).to be_a(LedgerSync::TestResource::TestChildResource)
      expect(child2.external_id).to eq('test_child2_resource_external_id')

      expect(grandchild).to be_a(LedgerSync::TestResource::TestGrandchildResource)
      expect(grandchild.external_id).to eq('test_grandchild_resource_external_id')
      expect(grandchild.useless_child).to be_nil
    end
  end

  it do
    h = {
      'expense' => {
        '3aab091a-1a8a-4c96-b86c-f145198da13d' => {
          data: {
            Currency: 'foo',
            PrivateNote: "Description: \nStatement Descriptor: \nRemittance Information: \nCreated by Matt Marcus at "\
                  '2019-10-24 18:21:53 UTC',
            PaymentType: 'cash',
            TxnDate: Date.new(2019, 10, 25),
            Entity: '928db55e-6552-4aaf-96d7-10c693922b1f',
            Account: 'd51889bb-7c89-4138-83f3-1489b11b8cbd',
            Line: [
              'e337cbce-3765-4a82-8e6f-3f7b960f5d67'
            ],
            DocNumber: '3aab091a1a8a4c96b86cf'
          }
        }
      },
      :vendor => {
        '928db55e-6552-4aaf-96d7-10c693922b1f' => {
          ledger_id: '83cf34d0-2ea3-4fe0-83ec-58e502ad6be1',
          data: {}
        }
      },
      :account => {
        'd51889bb-7c89-4138-83f3-1489b11b8cbd' => {
          ledger_id: '36',
          data: {}
        },
        'bba2464e-cc79-4c25-9ff6-a732d53e6fa6' => {
          ledger_id: '84',
          data: {}
        }
      },
      :expense_line => {
        'e337cbce-3765-4a82-8e6f-3f7b960f5d67' => {
          data: {
            Amount: 2500,
            Description: nil
          }
        }
      },
      :currency => {
        'foo' => {
          data: {
            Name: 'United States Dollar',
            Symbol: 'USD'
          }
        }
      }
    }

    builder = described_class.new(
      data: h,
      ledger: :quickbooks_online,
      root_resource_external_id: '3aab091a-1a8a-4c96-b86c-f145198da13d',
      root_resource_type: 'expense'
    )

    resource = builder.resource

    expect(resource).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Expense)
    expect(resource.Entity).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Vendor)
    expect(resource.Currency).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Currency)
  end
end

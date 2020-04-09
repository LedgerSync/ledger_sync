# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Invoice::LedgerSerializer do
  let(:location_ledger_id) { '12' }
  let(:location) { FactoryBot.create(:location, ledger_id: location_ledger_id) }

  let(:customer_ledger_id) { '456' }
  let(:customer) { FactoryBot.create(:customer, ledger_id: customer_ledger_id) }

  let(:item1_ledger_id) { '876' }
  let(:item1) { FactoryBot.create(:item, ledger_id: item1_ledger_id) }

  let(:item2_ledger_id) { '990' }
  let(:item2) { FactoryBot.create(:item, ledger_id: item2_ledger_id) }

  let(:line_items) do
    [
      FactoryBot.create(
        :invoice_sales_line_item,
        item: item1
      ),
      FactoryBot.create(
        :invoice_sales_line_item,
        item: item2
      )
    ]
  end

  let(:resource) do
    LedgerSync::Invoice.new(
      customer: customer,
      line_items: line_items,
      location: location
    )
  end

  let(:h) do
    {
      'entity' => customer_ledger_id,
      'location' => location_ledger_id,
      'item' => {
        'items' => [
          {
            'item' => { 'id' => item1_ledger_id }
          },
          {
            'item' => { 'id' => item2_ledger_id }
          }
        ]
      }
    }
  end

  describe '#to_ledger_hash' do
    it do
      serializer = described_class.new(resource: resource)
      expect(serializer.to_ledger_hash).to eq(h)
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync::Invoice.new }

    it do
      deserializer_class = LedgerSync::Adaptors::NetSuite::Invoice::LedgerDeserializer
      serializer = deserializer_class.new(resource: resource)
      invoice_ledger_id = '747'
      deserialized_resource = serializer.deserialize(hash: h.merge('id' => invoice_ledger_id))
      expect(resource.ledger_id).to be_nil
      expect(resource.location).to be_nil
      expect(resource.customer).to be_nil
      expect(resource.line_items).to be_empty
      expect(deserialized_resource.ledger_id).to eq(invoice_ledger_id)
      expect(deserialized_resource.location.ledger_id).to eq(location_ledger_id)
      expect(deserialized_resource.customer.ledger_id).to eq(customer_ledger_id)
      expect(deserialized_resource.line_items.count).to eq(2)
      item_ledger_ids = deserialized_resource.line_items.map { |e| e.item.ledger_id }
      expect(item_ledger_ids).to include(item1_ledger_id)
      expect(item_ledger_ids).to include(item2_ledger_id)
    end
  end
end

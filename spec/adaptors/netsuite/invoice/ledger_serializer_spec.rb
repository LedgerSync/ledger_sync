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

  let(:memo) { 'a memo' }
  let(:line_item1_description) { 'line item 1' }
  let(:line_item2_description) { 'line item 2' }
  let(:line_item1_amount) { 123 }
  let(:line_item2_amount) { 987 }

  let(:line_items) do
    [
      FactoryBot.create(
        :invoice_sales_line_item,
        description: line_item1_description,
        amount: line_item1_amount,
        item: item1,
        quantity: 1.0
      ),
      FactoryBot.create(
        :invoice_sales_line_item,
        description: line_item2_description,
        amount: line_item2_amount,
        item: item2,
        quantity: 2.5
      )
    ]
  end

  let(:resource) do
    LedgerSync::Invoice.new(
      customer: customer,
      line_items: line_items,
      location: location,
      memo: memo
    )
  end

  let(:h) do
    {
      'entity' => customer_ledger_id,
      'location' => location_ledger_id,
      'item' => {
        'items' => [
          {
            'amount' => line_item1_amount,
            'description' => line_item1_description,
            'item' => { 'id' => item1_ledger_id },
            'quantity' => 1.0
          },
          {
            'amount' => line_item2_amount,
            'description' => line_item2_description,
            'item' => { 'id' => item2_ledger_id },
            'quantity' => 2.5
          }
        ]
      },
      'memo' => memo
    }
  end

  describe '#to_ledger_hash' do
    it do
      serializer = described_class.new(resource: resource)
      ledger_hash = serializer.to_ledger_hash
      expect(ledger_hash).to eq(h)
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync::Invoice.new }

    it do
      deserializer_class = LedgerSync::Adaptors::NetSuite::Invoice::LedgerDeserializer
      serializer = deserializer_class.new(resource: resource)
      deserialized_resource = serializer.deserialize(hash: NETSUITE_RECORDS[:invoice][:ledger_body])
      expect(deserialized_resource.ledger_id).to eq('1227')
      expect(deserialized_resource.memo).to eq('Testing Memo')
      expect(deserialized_resource.location.ledger_id).to eq('1')
      expect(deserialized_resource.customer.ledger_id).to eq('7938')
      expect(deserialized_resource.line_items.count).to eq(2)
      item_ledger_ids = deserialized_resource.line_items.map { |e| e.item.ledger_id }
      expect(item_ledger_ids).to include(item1_ledger_id)
      expect(item_ledger_ids).to include(item2_ledger_id)
    end
  end
end

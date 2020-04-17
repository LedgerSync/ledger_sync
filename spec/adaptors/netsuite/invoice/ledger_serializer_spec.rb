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
      invoice_ledger_id = '747'
      response_h = {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227'
          }
        ],
        "amountpaid": 0.0,
        "amountremaining": 2010.0,
        "amountremainingtotalbox": 2010.0,
        "balance": 1910.0,
        "billingaddress": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/billingaddress'
            }
          ]
        },
        "canHaveStackable": false,
        "createdDate": '2020-04-07T11:53:00Z',
        "currency": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/currency/1'
            }
          ],
          "id": '1',
          "refName": 'USA'
        },
        "currencyName": 'USA',
        "currencysymbol": 'USD',
        "custbody_atlas_exist_cust_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_cust_type/2'
            }
          ],
          "id": '2',
          "refName": 'Existing Customer'
        },
        "custbody_atlas_help_trans_lp_ref": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customrecord_atlas_help_reference/4'
            }
          ],
          "id": '4',
          "refName": 'Order to Cash'
        },
        "custbody_atlas_new_cust_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_cust_type/1'
            }
          ],
          "id": '1',
          "refName": 'New Customer'
        },
        "custbody_atlas_no_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_appr_by_creator/2'
            }
          ],
          "id": '2',
          "refName": 'No'
        },
        "custbody_atlas_yes_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_appr_by_creator/1'
            }
          ],
          "id": '1',
          "refName": 'Yes'
        },
        "custbody_esc_created_date": '2020-04-07',
        "custbody_esc_last_modified_date": '2020-04-07',
        "customForm": '131',
        "discountTotal": 0.0,
        "email": 'ryan-test-co@example.com',
        "entity": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/7938'
            }
          ],
          "id": '7938',
          "refName": 'Ryan Test Co.'
        },
        "entityNexus": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/nexus/2'
            }
          ],
          "id": '2',
          "refName": 'CA'
        },
        "estGrossProfit": 2010.0,
        "estGrossProfitPercent": 100.0,
        "exchangeRate": 1.0,
        "id": '1227',
        "isBaseCurrency": true,
        "isTaxable": false,
        "item": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/item'
            }
          ]
        },
        "lastModifiedDate": '2020-04-07T13:34:00Z',
        "location": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/location/1'
            }
          ],
          "id": '1',
          "refName": 'Modern Treasury'
        },
        "memo": "Testing Memo",
        "nexus": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/nexus/2'
            }
          ],
          "id": '2',
          "refName": 'CA'
        },
        "postingperiod": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/accountingperiod/20'
            }
          ],
          "id": '20',
          "refName": 'Jan 2018'
        },
        "saleseffectivedate": '2020-04-06',
        "shipDate": '2020-04-06',
        "shipIsResidential": false,
        "shipOverride": false,
        "shippingAddress": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/shippingAddress'
            }
          ]
        },
        "status": 'Open',
        "subsidiary": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/subsidiary/2'
            }
          ],
          "id": '2',
          "refName": 'Modern Treasury'
        },
        "subtotal": 2010.0,
        "taxItem": {
          "links": [],
          "id": '-7',
          "refName": '-Not Taxable-'
        },
        "taxRate": 0.0,
        "toBeEmailed": false,
        "toBeFaxed": false,
        "toBePrinted": false,
        "total": 2010.0,
        "totalCostEstimate": 0.0,
        "trandate": '2020-04-06',
        "tranId": 'INV01'
      }
      deserialized_resource = serializer.deserialize(hash: response_h)
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

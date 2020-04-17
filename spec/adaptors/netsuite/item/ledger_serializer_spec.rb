# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Item::LedgerSerializer do
  let(:resource_type) { :item }
  let(:id) { '123' }
  let(:name) { 'Item Name' }
  let(:resource) do
    FactoryBot.create(
      resource_type,
      ledger_id: id,
      name: name
    )
  end

  let(:h) do
    {
      "links": [
        {
          "rel": 'self',
          "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/noninventoryitem/5'
        }
      ],
      "costEstimateType": 'ITEMDEFINED',
      "createdDate": '2019-08-27T18:14:00Z',
      "customForm": '33',
      "enforceminqtyinternally": true,
      "id": id,
      "includeChildren": false,
      "incomeAccount": {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/account/54'
          }
        ],
        "id": '54',
        "refName": '4020 Sales'
      },
      "isFulfillable": true,
      "isInactive": false,
      "itemId": 'Test Item',
      "itemType": 'NonInvtPart',
      "lastModifiedDate": '2019-08-27T18:14:00Z',
      "subsidiary": {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/noninventoryitem/5/subsidiary'
          }
        ]
      },
      "subtype": 'Sale',
      "taxSchedule": {
        "links": [],
        "id": '2',
        "refName": 'Non-Taxable'
      },
      "translations": {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/noninventoryitem/5/translations'
          }
        ]
      },
      "useMarginalRates": false
    }
  end

  describe '#to_ledger_hash' do
    let(:serializer) { described_class.new(resource: resource) }

    it do
      expect(serializer.to_ledger_hash).to eq(h.slice('id', 'name'))
    end
  end

  describe '#deserialize' do
    let(:resource) { LedgerSync.resources[resource_type].new }
    let(:serializer) { described_class.new(resource: resource) }
    let(:deserialized_resource) { serializer.deserialize(hash: h) }

    it do
      ledger_hash = {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/pricelevel/1'
          }
        ],
        "id": '1',
        "longitemtype": 'Price Level',
        "name": 'Base Price',
        "tname": 'pricetype'
      }
      deserialized_resource = serializer.deserialize(hash: ledger_hash)
      expect(deserialized_resource.ledger_id).to eq('1')
      expect(deserialized_resource.name).to eq('Base Price')
      expect(deserialized_resource.type).to eq(:price_type)
    end
  end
end

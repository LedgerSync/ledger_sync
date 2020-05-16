# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Vendor::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:companyname) { 'company-name-asdf' }
  let(:phone) { '321654987' }

  let(:h) do
    {
      'id' => id,
      'companyname' => companyname,
      'phone' => phone
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::Vendor.new) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.company_name).to eq(companyname)
      expect(deserialized_resource.phone_number).to eq(phone)
    end
  end
end

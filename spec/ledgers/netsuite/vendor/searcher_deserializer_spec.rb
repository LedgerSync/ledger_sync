# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Customer::SearcherDeserializer do
  let(:id) { 'ledger_id_asdf' }
  let(:email) { 'company@test.com' }
  let(:companyname) { 'company asdf' }
  let(:phone) { '321654987' }

  let(:h) do
    {
      'id' => id,
      'email' => email,
      'companyname' => companyname,
      'phone' => phone
    }
  end

  describe '#deserialize' do
    let(:serializer) { described_class.new }
    let(:deserialized_resource) { serializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::Customer.new) }

    it do
      expect(deserialized_resource.ledger_id).to eq(id)
      expect(deserialized_resource.email).to eq(email)
      expect(deserialized_resource.companyName).to eq(companyname)
      expect(deserialized_resource.phone).to eq(phone)
    end
  end
end

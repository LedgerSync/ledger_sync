# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Serializer do
  let(:customer) { LedgerSync::Customer.new(ledger_id: id, name: name, email: email, phone_number: phone_number) }
  let(:id) { '123' }
  let(:name) { 'test_name' }
  let(:email) { 'test_email' }
  let(:phone_number) { 'test_phone_number' }

  let(:h) do
    {
      'DisplayName' => name,
      'Id' => id,
      'PrimaryPhone' => {
        'FreeFormNumber' => phone_number
      },
      'PrimaryEmailAddr' => {
        'Address' => email
      }
    }
  end

  describe '#to_h' do
    it do
      serializer = described_class.new(resource: customer)
      expect(serializer.to_h).to eq(h.reject { |e| e == 'Id' })
    end
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Customer.new }

    it do
      serializer = described_class.new(resource: customer)
      deserialized_customer = serializer.deserialize(h)
      expect(customer.email).to be_nil
      expect(customer.name).to be_nil
      expect(customer.phone_number).to be_nil
      expect(deserialized_customer.email).to eq(email)
      expect(deserialized_customer.name).to eq(name)
      expect(deserialized_customer.phone_number).to eq(phone_number)
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Serialization::DeserializerAttribute do
  include SerializationHelpers

  let(:attribute) do
    described_class.new(
      block: nil,
      resource_attribute: :asdf,
      type: LedgerSync::Type::Value
    )
  end

  describe '#build_resource_value_from_nested_attributes' do
    it do
      resource = attribute.send(
        :build_resource_value_from_nested_attributes,
        LedgerSync::Ledgers::QuickBooksOnline::Payment.new,
        'asdf',
        'customer.ledger_id'.split('.')
      )

      expect(resource.customer.ledger_id).to eq('asdf')
    end
  end
end

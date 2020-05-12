# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Ledgers::LedgerSerializerAttribute do
  include LedgerSerializerHelpers

  let(:attribute) do
    described_class.new(
      block: nil,
      id: false,
      ledger_attribute: :asdf,
      resource_attribute: nil,
      serializer: nil,
      type: LedgerSync::Ledgers::LedgerSerializerType::ValueType
    )
  end

  describe '#build_resource_value_from_nested_attributes' do
    it do
      resource = attribute.send(
        :build_resource_value_from_nested_attributes,
        LedgerSync::Payment.new,
        'asdf',
        'customer.ledger_id'.split('.')
      )

      expect(resource.customer.ledger_id).to eq('asdf')
    end
  end
end

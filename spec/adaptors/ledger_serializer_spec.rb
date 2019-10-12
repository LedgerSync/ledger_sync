# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::LedgerSerializer do
  include LedgerSerializerHelpers

  describe '#build_resource_value_from_nested_attributes' do
    it do
      allow_any_instance_of(described_class).to receive(:ensure_inferred_resource_class) { nil }
      serializer = described_class.new(resource: :foo)
      resource = serializer.send(
        :build_resource_value_from_nested_attributes,
        LedgerSync::Expense.new,
        'asdf',
        'vendor.ledger_id'.split('.')
      )

      expect(resource.vendor.ledger_id).to eq('asdf')
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Expense do
  describe '#entity' do
    it do
      expect { described_class.new(entity: LedgerSync::Customer.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(entity: LedgerSync::Vendor.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(entity: LedgerSync::Bill.new) }.to raise_error(
        LedgerSync::ResourceError::AttributeTypeError,
        'Attribute entity for LedgerSync::Expense should be one of the following: LedgerSync::Customer, LedgerSync::Vendor.  Given LedgerSync::Bill'
      )
    end
  end
end

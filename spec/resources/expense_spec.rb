# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  describe '#entity' do
    it do
      expect { described_class.new(entity: LedgerSync::Ledgers::QuickBooksOnline::Customer.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(entity: LedgerSync::Ledgers::QuickBooksOnline::Vendor.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(entity: LedgerSync::Ledgers::QuickBooksOnline::Bill.new) }.to raise_error(
        LedgerSync::ResourceAttributeError::TypeError,
        'Attribute entity for LedgerSync::Expense should be one of the following: LedgerSync::Customer, LedgerSync::Vendor.  Given LedgerSync::Bill'
      )
    end
  end
end

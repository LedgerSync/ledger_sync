# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense do
  describe '#entity' do
    it do
      expect { described_class.new(Entity: LedgerSync::Ledgers::QuickBooksOnline::Customer.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(Entity: LedgerSync::Ledgers::QuickBooksOnline::Vendor.new) }.not_to raise_error
    end

    it do
      expect { described_class.new(Entity: LedgerSync::Ledgers::QuickBooksOnline::Bill.new) }.to raise_error(
        LedgerSync::ResourceAttributeError::TypeError,
        'Attribute Entity for LedgerSync::Ledgers::QuickBooksOnline::Expense should be one of the following: '\
        'LedgerSync::Ledgers::QuickBooksOnline::Customer, LedgerSync::Ledgers::QuickBooksOnline::Vendor.  '\
        'Given LedgerSync::Ledgers::QuickBooksOnline::Bill'
      )
    end
  end
end

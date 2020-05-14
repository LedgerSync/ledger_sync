# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  let(:currency) do
    create(
      :quickbooks_online_currency
    )
  end
  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new }

  it do
    expect(LedgerSync::Ledgers::QuickBooksOnline::Expense.new(currency: currency)).to be_changed
    expense = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
    expect(expense).not_to be_changed
  end

  context 'when references_many' do
    it '<<' do
      e = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
      eli = LedgerSync::Ledgers::QuickBooksOnline::ExpenseLineItem.new
      expect(e.changes).to be_empty
      expect(e.line_items).not_to be_changed
      expect(e.line_items.changes).to eq({})
      e.line_items << eli
      expect(e.line_items).to be_changed
      expect(e.line_items.changes).to eq('value' => [[], [eli]])
      expect(e).to be_changed
      expect(e.changes).to have_key('line_items')
      e.save
      expect(e.line_items).not_to be_changed
      expect(e).not_to be_changed
    end
  end

  context 'when references_one' do
    it '<<' do
      e = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
      account = LedgerSync::Ledgers::QuickBooksOnline::Account.new
      expect(e.changes).to be_empty
      e.account = account
      expect(e.changes).to have_key('account')
    end
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.external_id).to be_nil
    resource.external_id = :asdf
    expect(resource.external_id).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to eq('external_id' => [nil, 'asdf'])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.external_id).to eq('asdf')
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to be_nil
    resource.ledger_id = :asdf
    expect(resource.ledger_id).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to eq('ledger_id' => [nil, 'asdf'])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to eq('asdf')
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.DisplayName).to be_nil
    resource.DisplayName = 'asdf'
    expect(resource.DisplayName).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to eq('DisplayName' => [nil, 'asdf'])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.DisplayName).to eq('asdf')
    expect(resource.changes).to eq({})
  end
end

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
    expect(LedgerSync::Ledgers::QuickBooksOnline::Expense.new(Currency: currency)).to be_changed
    expense = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
    expect(expense).not_to be_changed
  end

  context 'when references_many' do
    it '<<' do
      e = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
      eli = LedgerSync::Ledgers::QuickBooksOnline::ExpenseLine.new
      expect(e.changes).to be_empty
      expect(e.Line).not_to be_changed
      expect(e.Line.changes).to eq({})
      e.Line << eli
      expect(e.Line).to be_changed
      expect(e.Line.changes).to eq('value' => [[], [eli]])
      expect(e).to be_changed
      expect(e.changes).to have_key('Line')
      e.save
      expect(e.Line).not_to be_changed
      expect(e).not_to be_changed
    end
  end

  context 'when references_one' do
    it '<<' do
      e = LedgerSync::Ledgers::QuickBooksOnline::Expense.new
      account = LedgerSync::Ledgers::QuickBooksOnline::Account.new
      expect(e.changes).to be_empty
      e.Account = account
      expect(e.changes).to have_key('Account')
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

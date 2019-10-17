require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  let(:resource) { LedgerSync::Customer.new }

  it do
    expect(LedgerSync::Expense.new(currency: 'USD')).to be_changed
    expense = LedgerSync::Expense.new
    expect(expense).not_to be_changed
  end

  context 'when references_many' do
    it '<<' do
      e = LedgerSync::Expense.new
      eli = LedgerSync::ExpenseLineItem.new
      expect(e.changes).to be_empty
      expect(e.line_items).not_to be_changed
      expect(e.line_items.changes).to eq({})
      e.line_items << eli
      expect(e.line_items).to be_changed
      expect(e.line_items.changes).to eq({ 'value' => [[], [eli]]})
      expect(e).to be_changed
      expect(e.changes).to have_key('line_items')
      e.save
      expect(e.line_items).not_to be_changed
      expect(e).not_to be_changed
    end
  end

  context 'when references_one' do
    it '<<' do
      e = LedgerSync::Expense.new
      account = LedgerSync::Account.new
      expect(e.changes).to be_empty
      e.account = account
      expect(e.changes).to have_key('account')
    end
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.external_id).to be_nil
    resource.external_id = :asdf
    expect(resource.external_id).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to eq('external_id' => [nil, :asdf])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.external_id).to eq(:asdf)
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.sync_token).to be_nil
    resource.sync_token = :asdf
    expect(resource.sync_token).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to eq('sync_token' => [nil, :asdf])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.sync_token).to eq(:asdf)
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to be_nil
    resource.ledger_id = :asdf
    expect(resource.ledger_id).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to eq('ledger_id' => [nil, :asdf])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to eq(:asdf)
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.name).to be_nil
    resource.name = 'asdf'
    expect(resource.name).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to eq('name' => [nil, 'asdf'])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.name).to eq('asdf')
    expect(resource.changes).to eq({})
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.phone_number).to be_nil
    resource.phone_number = 'asdf'
    expect(resource.phone_number).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to eq('phone_number' => [nil, 'asdf'])
    resource.save
    expect(resource).not_to be_changed
    expect(resource.phone_number).to eq('asdf')
    expect(resource.changes).to eq({})
  end
end
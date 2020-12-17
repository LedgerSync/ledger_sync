# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  let(:resource) { LedgerSync::Ledgers::TestLedger::Customer.new }
  let(:subsidiary_1) { LedgerSync::Ledgers::TestLedger::Subsidiary.new }
  let(:subsidiary_2) { LedgerSync::Ledgers::TestLedger::Subsidiary.new }

  it do
    expect(LedgerSync::Ledgers::TestLedger::Customer.new(name: 'test')).to be_changed
    expense = LedgerSync::Ledgers::TestLedger::Customer.new
    expect(expense).not_to be_changed
  end

  context 'when references_many' do
    it '<<' do
      c = LedgerSync::Ledgers::TestLedger::Customer.new
      s = LedgerSync::Ledgers::TestLedger::Subsidiary.new
      expect(c.changes).to be_empty
      expect(c.subsidiaries).not_to be_changed
      expect(c.subsidiaries.changes).to eq({})
      c.subsidiaries << s
      expect(c.subsidiaries).to be_changed
      expect(c.subsidiaries.changes).to eq('value' => [[], [s]])
      expect(c).to be_changed
      expect(c.changes).to have_key('subsidiaries')
      c.save
      expect(c.subsidiaries).not_to be_changed
      expect(c).not_to be_changed
    end
  end

  context 'when references_one' do
    it '<<' do
      c = LedgerSync::Ledgers::TestLedger::Customer.new
      s = LedgerSync::Ledgers::TestLedger::Subsidiary.new
      expect(c.changes).to be_empty
      c.subsidiary = s
      expect(c.changes).to have_key('subsidiary')
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
end

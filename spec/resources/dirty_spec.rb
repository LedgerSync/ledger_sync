require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  let(:resource) { LedgerSync::Customer.new }


  it do
    expect(resource).not_to be_changed
    expect(resource.external_id).to be_nil
    resource.external_id = :asdf
    expect(resource.external_id).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to have_key('external_id')
    resource.save
    expect(resource).not_to be_changed
    expect(resource.external_id).to eq(:asdf)
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.sync_token).to be_nil
    resource.sync_token = :asdf
    expect(resource.sync_token).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to have_key('sync_token')
    resource.save
    expect(resource).not_to be_changed
    expect(resource.sync_token).to eq(:asdf)
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to be_nil
    resource.ledger_id = :asdf
    expect(resource.ledger_id).to eq(:asdf)
    expect(resource).to be_changed
    expect(resource.changes).to have_key('ledger_id')
    resource.save
    expect(resource).not_to be_changed
    expect(resource.ledger_id).to eq(:asdf)
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.name).to be_nil
    resource.name = 'asdf'
    expect(resource.name).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to have_key('name')
    resource.save
    expect(resource).not_to be_changed
    expect(resource.name).to eq('asdf')
  end

  it do
    expect(resource).not_to be_changed
    expect(resource.phone_number).to be_nil
    resource.phone_number = 'asdf'
    expect(resource.phone_number).to eq('asdf')
    expect(resource).to be_changed
    expect(resource.changes).to have_key('phone_number')
    resource.save
    expect(resource).not_to be_changed
    expect(resource.phone_number).to eq('asdf')
  end
end
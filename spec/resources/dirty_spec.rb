require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  let(:resource) { LedgerSync::Customer.new }

  it do
    expect(resource).not_to be_changed
    resource.external_id = :asdf
    expect(resource).to be_changed
    expect(resource.changes).to have_key('external_id')
    resource.save
    expect(resource).not_to be_changed
  end

  it do
    expect(resource).not_to be_changed
    resource.sync_token = :asdf
    expect(resource).to be_changed
    expect(resource.changes).to have_key('sync_token')
    resource.save
    expect(resource).not_to be_changed
  end

  it do
    expect(resource).not_to be_changed
    resource.ledger_id = :asdf
    expect(resource).to be_changed
    expect(resource.changes).to have_key('ledger_id')
    resource.save
    expect(resource).not_to be_changed
  end

  it do
    expect(resource).not_to be_changed
    resource.name = 'asdf'
    expect(resource).to be_changed
    expect(resource.changes).to have_key('name')
    resource.save
    expect(resource).not_to be_changed
  end

  it do
    expect(resource).not_to be_changed
    resource.phone_number = 'asdf'
    expect(resource).to be_changed
    expect(resource.changes).to have_key('phone_number')
    resource.save
    expect(resource).not_to be_changed
  end
end
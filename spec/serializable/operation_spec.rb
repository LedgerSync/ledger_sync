# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples

RSpec.describe LedgerSync::Ledgers::TestLedger::Customer::Operations::Create, type: :serializable do
  let(:client) { LedgerSync::Ledgers::TestLedger::Client.new(api_key: :api_key) }
  let(:resource) { LedgerSync::Ledgers::TestLedger::Customer.new(name: 'asdf') }
  let(:operation) { new_resource }

  def new_resource
    described_class.new(
      client: client,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Ledgers::TestLedger::Customer::Operations::Find.new(
      client: client,
      resource: LedgerSync::Ledgers::TestLedger::Customer.new(date: Date.today)
    )
    expect(operation.send(:validation_data)[:date]).to be_a(Date)
  end

  it_behaves_like 'a serializable object'
end

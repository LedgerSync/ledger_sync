# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource, type: :serializable do
  let(:customer) { LedgerSync::Customer.new(name: 'John Doe') }
  let(:payment) { LedgerSync::Payment.new(amount: 1.23, customer: customer) }

  subject { payment.serialize }

  it do
    h = {
      objects: { 'LedgerSync::Customer/c109732a24280f88ac9dd952095c1dea' => { data: { email: nil, external_id: :"", ledger_id: nil, name: 'John Doe', phone_number: nil, sync_token: nil }, fingeprint: 'c109732a24280f88ac9dd952095c1dea', id: 'LedgerSync::Customer/c109732a24280f88ac9dd952095c1dea', object: 'LedgerSync::Customer' }, 'LedgerSync::Payment/ab4dd4ba29649ad562ec04d7761a15d2' => { data: { amount: 1.23, currency: nil, customer: { id: 'LedgerSync::Customer/c109732a24280f88ac9dd952095c1dea', object: :reference }, external_id: :"", ledger_id: nil, sync_token: nil }, fingeprint: 'ab4dd4ba29649ad562ec04d7761a15d2', id: 'LedgerSync::Payment/ab4dd4ba29649ad562ec04d7761a15d2', object: 'LedgerSync::Payment' } },
      root: 'LedgerSync::Payment/ab4dd4ba29649ad562ec04d7761a15d2'
    }
    expect(subject).to eq(h)
  end
end

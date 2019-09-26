# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource, type: :serializable do
  let(:customer) { LedgerSync::Customer.new(name: 'John Doe') }
  let(:payment) { LedgerSync::Payment.new(amount: 1.23, customer: customer) }

  subject { payment.serialize }

  it do
    h = {
      root: 'LedgerSync::Payment/068b443fe06412fb67d1fa16c5c85050',
      objects: {
        'LedgerSync::Payment/068b443fe06412fb67d1fa16c5c85050' => {
          id: 'LedgerSync::Payment/068b443fe06412fb67d1fa16c5c85050',
          object: 'LedgerSync::Payment',
          fingeprint: '068b443fe06412fb67d1fa16c5c85050',
          data: {
            amount: 1.23,
            customer: {
              object: :reference,
              id: 'LedgerSync::Customer/3bdc467dfa0599f180f814f883c8f9cd'
            },
            currency: nil,
            ledger_id: nil,
            sync_token: nil,
            external_id: :""
          }
        },
        'LedgerSync::Customer/3bdc467dfa0599f180f814f883c8f9cd' => {
          id: 'LedgerSync::Customer/3bdc467dfa0599f180f814f883c8f9cd',
          object: 'LedgerSync::Customer',
          fingeprint: '3bdc467dfa0599f180f814f883c8f9cd',
          data: {
            phone_number: nil,
            name: 'John Doe',
            email: nil,
            ledger_id: nil,
            sync_token: nil,
            external_id: :""
          }
        }
      }
    }
    expect(subject).to eq(h)
  end
end

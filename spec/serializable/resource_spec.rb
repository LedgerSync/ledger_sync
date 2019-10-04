# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Resource, type: :serializable do
  let(:customer) { LedgerSync::Customer.new(name: 'John Doe') }
  let(:payment) { LedgerSync::Payment.new(amount: 123, customer: customer) }

  subject { payment.serialize }

  it do
    h = {
      objects: {
        'LedgerSync::Customer/f402c4135c3b4ae1302a154da0740995' => {
          data: {
            email: nil,
            external_id: nil,
            ledger_id: nil,
            name: 'John Doe',
            phone_number: nil,
            sync_token: nil
          },
          fingeprint: 'f402c4135c3b4ae1302a154da0740995',
          id: 'LedgerSync::Customer/f402c4135c3b4ae1302a154da0740995',
          object: 'LedgerSync::Customer'
        },
        'LedgerSync::Payment/dd1cccdfbdbbc83533b3445f7765e94e' => {
          data: {
            amount: 123,
            currency: nil,
            customer: {
              id: 'LedgerSync::Customer/f402c4135c3b4ae1302a154da0740995',
              object: :reference
            },
            external_id: nil,
            ledger_id: nil,
            sync_token: nil
          },
          fingeprint: 'dd1cccdfbdbbc83533b3445f7765e94e',
          id: 'LedgerSync::Payment/dd1cccdfbdbbc83533b3445f7765e94e',
          object: 'LedgerSync::Payment'
        }
      },
      root: 'LedgerSync::Payment/dd1cccdfbdbbc83533b3445f7765e94e'
    }
    expect(subject).to eq(h)
  end
end

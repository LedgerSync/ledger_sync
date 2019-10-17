# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Create, type: :serializable do
  include AdaptorHelpers

  let(:adaptor) { test_adaptor }
  let(:resource) { LedgerSync::Customer.new(name: 'asdf') }
  let(:operation) do
    described_class.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Adaptors::Test::Expense::Operations::Find.new(
      adaptor: adaptor,
      resource: LedgerSync::Expense.new(transaction_date: Date.today)
    )
    expect(operation.send(:validation_data)[:transaction_date]).to be_a(Date)
  end

  xit do
    allow(operation).to receive(:id) { 'asdf' }
    operation.perform
    allow(resource).to receive(:ledger_id) { 'asdf' }

    serialized_operation = operation.serialize

    h = {
      root: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/a655f101ad00f03c69d52894f92c1b83',
      objects: {
        'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => {
          data: {
            aliases: [:test],
            module: 'Test',
            rate_limiting_wait_in_seconds: 47,
            root_key: :test,
            test: true
          },
          fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
          id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
          object: 'LedgerSync::AdaptorConfiguration'
        },
        'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => {
          data: {
            adaptor_configuration: {
              id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
              object: :reference
            }
          },
          fingeprint: 'd751713988987e9331980363e24189ce',
          id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
          object: 'LedgerSync::Adaptors::Test::Adaptor'
        },
        'LedgerSync::Adaptors::Test::Customer::Operations::Create/a655f101ad00f03c69d52894f92c1b83' => {
          data: {
            adaptor: {
              id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
              object: :reference
            },
            after_operations: [],
            before_operations: [],
            operations: [],
            original: nil,
            resource: {
              id: 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34',
              object: :reference
            },
            response: nil,
            result: {
              id: 'LedgerSync::OperationResult::Success/ebec7a91733762725f45b6d49257aec3',
              object: :reference
            },
            root_operation: nil
          },
          fingeprint: 'a655f101ad00f03c69d52894f92c1b83',
          id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/a655f101ad00f03c69d52894f92c1b83',
          object: 'LedgerSync::Adaptors::Test::Customer::Operations::Create'
        },
        'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34' => {
          data: {
            email: nil,
            external_id: nil,
            ledger_id: 'asdf',
            name: 'asdf',
            phone_number: nil,
            sync_token: nil
          },
          fingeprint: 'd9f523a3395af66f5bfe48b79e657b34',
          id: 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34',
          object: 'LedgerSync::Customer'
        },
        'LedgerSync::OperationResult::Success/ebec7a91733762725f45b6d49257aec3' => {
          data: {
            operation: {
              id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/a655f101ad00f03c69d52894f92c1b83',
              object: :reference
            },
            resource: {
              id: 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34',
              object: :reference
            },
            response: {
              'email' => nil,
              'id' => 'asdf',
              'name' => 'asdf',
              'phone_number' => nil
            },
            value: {
              id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/a655f101ad00f03c69d52894f92c1b83',
              object: :reference
            }
          },
          fingeprint: 'ebec7a91733762725f45b6d49257aec3',
          id: 'LedgerSync::OperationResult::Success/ebec7a91733762725f45b6d49257aec3',
          object: 'LedgerSync::OperationResult::Success'
        }
      }
    }
    expect(serialized_operation).to eq(h)
  end
end

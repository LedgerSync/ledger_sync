# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Create, type: :serializable do
  include AdaptorHelpers

  let(:adaptor) { test_adaptor }
  let(:resource) { LedgerSync::Customer.new(name: :asdf) }
  let(:operation) do
    described_class.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  # TODO: Add test to ensure that the data contains an actual DateTime object (need an object that has a DT attr first)
  xit 'does not serialize dates' do
    expect(operation.send(:validation_data)).to eq({})
  end

  it do
    allow(operation).to receive(:id) { 'asdf' }
    operation.perform
    allow(resource).to receive(:ledger_id) { 'asdf' }

    serialized_operation = operation.serialize

    h = {
      root: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/3baa9cc206d4580cf618c94d3712c934',
      objects: {
        'LedgerSync::Adaptors::Test::Customer::Operations::Create/3baa9cc206d4580cf618c94d3712c934' => {
          id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/3baa9cc206d4580cf618c94d3712c934',
          object: 'LedgerSync::Adaptors::Test::Customer::Operations::Create',
          fingeprint: '3baa9cc206d4580cf618c94d3712c934',
          data: {
            adaptor: {
              object: :reference,
              id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce'
            },
            after_operations: [],
            before_operations: [],
            operations: [],
            resource: {
              object: :reference,
              id: 'LedgerSync::Customer/51e9fc4237edee29bb03eb221be1a92b'
            },
            root_operation: nil,
            result: {
              object: :reference,
              id: 'LedgerSync::OperationResult::Success/26ab2f20aa18f86e185806d64957be1c'
            },
            response: nil,
            original: nil
          }
        },
        'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => {
          id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
          object: 'LedgerSync::Adaptors::Test::Adaptor',
          fingeprint: 'd751713988987e9331980363e24189ce',
          data: {
            adaptor_configuration: {
              object: :reference,
              id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff'
            }
          }
        },
        'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => {
          id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
          object: 'LedgerSync::AdaptorConfiguration',
          fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
          data: {
            aliases: [
              :test
            ],
            module: 'Test',
            root_key: :test,
            rate_limiting_wait_in_seconds: 47,
            test: true
          }
        },
        'LedgerSync::Customer/51e9fc4237edee29bb03eb221be1a92b' => {
          id: 'LedgerSync::Customer/51e9fc4237edee29bb03eb221be1a92b',
          object: 'LedgerSync::Customer',
          fingeprint: '51e9fc4237edee29bb03eb221be1a92b',
          data: {
            name: :asdf,
            email: nil,
            phone_number: nil,
            external_id: :"",
            ledger_id: 'asdf',
            sync_token: nil
          }
        },
        'LedgerSync::OperationResult::Success/26ab2f20aa18f86e185806d64957be1c' => {
          id: 'LedgerSync::OperationResult::Success/26ab2f20aa18f86e185806d64957be1c',
          object: 'LedgerSync::OperationResult::Success',
          fingeprint: '26ab2f20aa18f86e185806d64957be1c',
          data: {
            value: {
              object: :reference,
              id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/3baa9cc206d4580cf618c94d3712c934'
            },
            operation: {
              object: :reference,
              id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/3baa9cc206d4580cf618c94d3712c934'
            },
            response: {
              :name => :asdf,
              :phone_number => nil,
              :email => nil,
              'id' => 'asdf'
            }
          }
        }
      }
    }
    expect(serialized_operation).to eq(h)
  end
end

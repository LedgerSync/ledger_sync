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
      root: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/08435416a2b7c5ef92e012e03cc0fd63',
      objects: { 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' =>
    { data: { aliases: [:test],
              module: 'Test',
              rate_limiting_wait_in_seconds: 47,
              root_key: :test,
              test: true },
      fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
      id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
      object: 'LedgerSync::AdaptorConfiguration' },
                 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' =>
    { data: { adaptor_configuration: { id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
                                       object: :reference } },
      fingeprint: 'd751713988987e9331980363e24189ce',
      id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
      object: 'LedgerSync::Adaptors::Test::Adaptor' },
                 'LedgerSync::Adaptors::Test::Customer::Operations::Create/08435416a2b7c5ef92e012e03cc0fd63' =>
    { data: { adaptor: { id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
                         object: :reference },
              after_operations: [],
              before_operations: [],
              operations: [],
              original: nil,
              resource: { id: 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34',
                          object: :reference },
              response: nil,
              result: { id: 'LedgerSync::OperationResult::Success/79dd28dcc06cef93c675406126ebf3cb',
                        object: :reference },
              root_operation: nil },
      fingeprint: '08435416a2b7c5ef92e012e03cc0fd63',
      id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/08435416a2b7c5ef92e012e03cc0fd63',
      object: 'LedgerSync::Adaptors::Test::Customer::Operations::Create' },
                 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34' =>
    { data: { email: nil,
              external_id: :"",
              ledger_id: 'asdf',
              name: 'asdf',
              phone_number: nil,
              sync_token: nil },
      fingeprint: 'd9f523a3395af66f5bfe48b79e657b34',
      id: 'LedgerSync::Customer/d9f523a3395af66f5bfe48b79e657b34',
      object: 'LedgerSync::Customer' },
                 'LedgerSync::OperationResult::Success/79dd28dcc06cef93c675406126ebf3cb' =>
    { data: { operation: { id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/08435416a2b7c5ef92e012e03cc0fd63',
                           object: :reference },
              response: { 'email' => nil, 'id' => 'asdf', 'name' => 'asdf', 'phone_number' => nil },
              value: { id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/08435416a2b7c5ef92e012e03cc0fd63',
                       object: :reference } },
      fingeprint: '79dd28dcc06cef93c675406126ebf3cb',
      id: 'LedgerSync::OperationResult::Success/79dd28dcc06cef93c675406126ebf3cb',
      object: 'LedgerSync::OperationResult::Success' } }
    }
    expect(serialized_operation).to eq(h)
  end
end

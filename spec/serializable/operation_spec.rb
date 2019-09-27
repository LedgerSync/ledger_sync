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

    h = { root: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/f4b4538623b2d79e55cf1c1eca29784a',
          objects: { 'LedgerSync::Adaptors::Test::Customer::Operations::Create/f4b4538623b2d79e55cf1c1eca29784a' =>
        { id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/f4b4538623b2d79e55cf1c1eca29784a',
          object: 'LedgerSync::Adaptors::Test::Customer::Operations::Create',
          fingeprint: 'f4b4538623b2d79e55cf1c1eca29784a',
          data: { adaptor: { object: :reference,
                             id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' },
                  after_operations: [],
                  before_operations: [],
                  operations: [],
                  resource: { object: :reference,
                              id: 'LedgerSync::Customer/f237221ec72aed6782c9f1dbdbeb7d67' },
                  root_operation: nil,
                  result: { object: :reference,
                            id: 'LedgerSync::OperationResult::Success/a36e4344cb8d04963e85c2b282416ac9' },
                  response: nil,
                  original: nil } },
                     'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' =>
        { id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
          object: 'LedgerSync::Adaptors::Test::Adaptor',
          fingeprint: 'd751713988987e9331980363e24189ce',
          data: { adaptor_configuration: { object: :reference,
                                           id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' } } },
                     'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' =>
        { id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
          object: 'LedgerSync::AdaptorConfiguration',
          fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
          data: { aliases: [:test],
                  module: 'Test',
                  root_key: :test,
                  rate_limiting_wait_in_seconds: 47,
                  test: true } },
                     'LedgerSync::Customer/f237221ec72aed6782c9f1dbdbeb7d67' =>
        { id: 'LedgerSync::Customer/f237221ec72aed6782c9f1dbdbeb7d67',
          object: 'LedgerSync::Customer',
          fingeprint: 'f237221ec72aed6782c9f1dbdbeb7d67',
          data: { phone_number: nil,
                  email: nil,
                  name: 'asdf',
                  ledger_id: 'asdf',
                  sync_token: nil,
                  external_id: :"" } },
                     'LedgerSync::OperationResult::Success/a36e4344cb8d04963e85c2b282416ac9' =>
        { id: 'LedgerSync::OperationResult::Success/a36e4344cb8d04963e85c2b282416ac9',
          object: 'LedgerSync::OperationResult::Success',
          fingeprint: 'a36e4344cb8d04963e85c2b282416ac9',
          data: { value: { object: :reference,
                           id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/f4b4538623b2d79e55cf1c1eca29784a' },
                  operation: { object: :reference,
                               id: 'LedgerSync::Adaptors::Test::Customer::Operations::Create/f4b4538623b2d79e55cf1c1eca29784a' },
                  response: { :name => 'asdf', :phone_number => nil, :email => nil, 'id' => 'asdf' } } } } }
    expect(serialized_operation).to eq(h)
  end
end

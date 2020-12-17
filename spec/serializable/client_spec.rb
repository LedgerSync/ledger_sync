# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::Client, type: :serializable do
  let(:test_ledger) { LedgerSync::Ledgers::TestLedger::Client.new(api_key: :api_key) }

  it do
    allow(LedgerSync::Ledgers::TestLedger::Client.config).to receive(:fingerprint).and_return('asdf')

    h = {
      root: 'LedgerSync::Ledgers::TestLedger::Client/d3fecf5221e8cae01e4f66e3899f555f',
      objects: {
        'LedgerSync::LedgerConfiguration/asdf' => {
          data: {
            aliases: [:test],
            base_module: 'LedgerSync::Ledgers::TestLedger',
            client_class: 'LedgerSync::Ledgers::TestLedger::Client',
            client_path: "#{LedgerSync.root}/lib/ledger_sync/test/support/test_ledger/client",
            name: 'Test Ledger',
            rate_limiting_wait_in_seconds: 60,
            root_key: :test_ledger,
            root_path: "#{LedgerSync.root}/lib/ledger_sync/test/support/test_ledger"
          },
          fingeprint: 'asdf',
          id: 'LedgerSync::LedgerConfiguration/asdf',
          object: 'LedgerSync::LedgerConfiguration'
        },
        'LedgerSync::Ledgers::TestLedger::Client/d3fecf5221e8cae01e4f66e3899f555f' => {
          data: {
            ledger_configuration: {
              id: 'LedgerSync::LedgerConfiguration/asdf',
              object: :reference
            }
          },
          fingeprint: 'd3fecf5221e8cae01e4f66e3899f555f',
          id: 'LedgerSync::Ledgers::TestLedger::Client/d3fecf5221e8cae01e4f66e3899f555f',
          object: 'LedgerSync::Ledgers::TestLedger::Client'
        }
      }
    }
    expect(test_ledger.simply_serialize).to eq(h)
  end

  it do
    client1 = LedgerSync.ledgers.test.new(
      api_key: 'api_key'
    )

    client2 = LedgerSync.ledgers.test.new(
      api_key: 'api_key'
    )

    client3 = LedgerSync.ledgers.test.new(
      api_key: 'not_api_key'
    )

    expect(client1.simply_serialize).to eq(client2.simply_serialize)
    expect(client1.simply_serialize).not_to eq(client3.simply_serialize)

    expect(client1.fingerprint).to eq(client2.fingerprint)
    expect(client1.fingerprint).not_to eq(client3.fingerprint)
  end
end

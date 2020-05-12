# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::Client, type: :serializable do
  include NetSuiteHelpers

  it do
    h = { root: 'LedgerSync::Ledgers::NetSuite::Client/be8b28e86017b6ea4cc7b1cfcc36b63e',
          objects: { 'LedgerSync::Ledgers::NetSuite::Client/be8b28e86017b6ea4cc7b1cfcc36b63e' =>
        { id: 'LedgerSync::Ledgers::NetSuite::Client/be8b28e86017b6ea4cc7b1cfcc36b63e',
          object: 'LedgerSync::Ledgers::NetSuite::Client',
          fingeprint: 'be8b28e86017b6ea4cc7b1cfcc36b63e',
          data: { ledger_configuration: { object: :reference,
                                          id: 'LedgerSync::LedgerConfiguration/1d1d22bbe6ff00b5508249b7cbd50cbe' } } },
                     'LedgerSync::LedgerConfiguration/1d1d22bbe6ff00b5508249b7cbd50cbe' =>
        { id: 'LedgerSync::LedgerConfiguration/1d1d22bbe6ff00b5508249b7cbd50cbe',
          object: 'LedgerSync::LedgerConfiguration',
          fingeprint: '1d1d22bbe6ff00b5508249b7cbd50cbe',
          data: { client_class: 'LedgerSync::Ledgers::NetSuite::Client',
                  name: 'NetSuite REST',
                  module_string: 'NetSuite',
                  root_key: :netsuite,
                  aliases: [],
                  base_module: 'LedgerSync::Ledgers::NetSuite' } } } }
    expect(netsuite_client.simply_serialize).to eq(h)
  end

  it do
    client1 = LedgerSync.ledgers.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    client2 = LedgerSync.ledgers.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    client3 = LedgerSync.ledgers.netsuite.new(
      account_id: 'DOES NOT MATCH',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    expect(client1.simply_serialize).to eq(client2.simply_serialize)
    expect(client1.simply_serialize).not_to eq(client3.simply_serialize)

    expect(client1.fingerprint).to eq(client2.fingerprint)
    expect(client1.fingerprint).not_to eq(client3.fingerprint)
  end
end

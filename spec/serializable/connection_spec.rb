# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::Connection, type: :serializable do
  include NetSuiteHelpers

  it do
    h = { root: 'LedgerSync::Ledgers::NetSuite::Connection/be8b28e86017b6ea4cc7b1cfcc36b63e',
          objects: { 'LedgerSync::Ledgers::NetSuite::Connection/be8b28e86017b6ea4cc7b1cfcc36b63e' =>
        { id: 'LedgerSync::Ledgers::NetSuite::Connection/be8b28e86017b6ea4cc7b1cfcc36b63e',
          object: 'LedgerSync::Ledgers::NetSuite::Connection',
          fingeprint: 'be8b28e86017b6ea4cc7b1cfcc36b63e',
          data: { ledger_configuration: { object: :reference,
                                          id: 'LedgerSync::LedgerConfiguration/dd1a77928fb7c45ded730f030daa353c' } } },
                     'LedgerSync::LedgerConfiguration/dd1a77928fb7c45ded730f030daa353c' =>
        { id: 'LedgerSync::LedgerConfiguration/dd1a77928fb7c45ded730f030daa353c',
          object: 'LedgerSync::LedgerConfiguration',
          fingeprint: 'dd1a77928fb7c45ded730f030daa353c',
          data: { base_module: 'LedgerSync::Ledgers::NetSuite',
                  connection_class: 'LedgerSync::Ledgers::NetSuite::Connection',
                  name: 'NetSuite REST',
                  module_string: 'NetSuite',
                  root_key: :netsuite,
                  aliases: [] } } } }

    expect(netsuite_connection.simply_serialize).to eq(h)
  end

  it do
    connection1 = LedgerSync.ledgers.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    connection2 = LedgerSync.ledgers.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    connection3 = LedgerSync.ledgers.netsuite.new(
      account_id: 'DOES NOT MATCH',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    expect(connection1.simply_serialize).to eq(connection2.simply_serialize)
    expect(connection1.simply_serialize).not_to eq(connection3.simply_serialize)

    expect(connection1.fingerprint).to eq(connection2.fingerprint)
    expect(connection1.fingerprint).not_to eq(connection3.fingerprint)
  end
end

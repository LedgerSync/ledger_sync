# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::Adaptor, type: :serializable do
  include NetSuiteHelpers

  it do
    h = {:root=>
      "LedgerSync::Adaptors::NetSuite::Adaptor/be8b28e86017b6ea4cc7b1cfcc36b63e",
     :objects=>
      {"LedgerSync::Adaptors::NetSuite::Adaptor/be8b28e86017b6ea4cc7b1cfcc36b63e"=>
        {:id=>
          "LedgerSync::Adaptors::NetSuite::Adaptor/be8b28e86017b6ea4cc7b1cfcc36b63e",
         :object=>"LedgerSync::Adaptors::NetSuite::Adaptor",
         :fingeprint=>"be8b28e86017b6ea4cc7b1cfcc36b63e",
         :data=>
          {:adaptor_configuration=>
            {:object=>:reference,
             :id=>
              "LedgerSync::AdaptorConfiguration/258e415522e6f04aead6d578f6abf9ac"}}},
       "LedgerSync::AdaptorConfiguration/258e415522e6f04aead6d578f6abf9ac"=>
        {:id=>"LedgerSync::AdaptorConfiguration/258e415522e6f04aead6d578f6abf9ac",
         :object=>"LedgerSync::AdaptorConfiguration",
         :fingeprint=>"258e415522e6f04aead6d578f6abf9ac",
         :data=>
          {:aliases=>[],
           :module_string=>"NetSuite",
           :root_key=>:netsuite,
           :rate_limiting_wait_in_seconds=>nil,
           :test=>nil}}}}
    expect(netsuite_adaptor.serialize).to eq(h)
  end

  it do
    adaptor1 = LedgerSync.adaptors.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    adaptor2 = LedgerSync.adaptors.netsuite.new(
      account_id: 'netsuite_account_id',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    adaptor3 = LedgerSync.adaptors.netsuite.new(
      account_id: 'DOES NOT MATCH',
      consumer_key: 'NETSUITE_CONSUMER_KEY',
      consumer_secret: 'NETSUITE_CONSUMER_SECRET',
      token_id: 'NETSUITE_TOKEN_ID',
      token_secret: 'NETSUITE_TOKEN_SECRET'
    )

    expect(adaptor1.serialize).to eq(adaptor2.serialize)
    expect(adaptor1.serialize).not_to eq(adaptor3.serialize)

    expect(adaptor1.fingerprint).to eq(adaptor2.fingerprint)
    expect(adaptor1.fingerprint).not_to eq(adaptor3.fingerprint)
  end
end

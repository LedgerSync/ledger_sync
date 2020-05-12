# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Client do
  include NetSuiteHelpers

  let(:account_id) { 'account_id' }
  let(:api_version) { '2016_2' }
  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }
  let(:token_id) { 'token_id' }
  let(:token_secret) { 'token_secret' }
  let(:client) { netsuite_client }

  subject do
    described_class.new(
      access_token: access_token,
      client_id: client_id,
      client_secret: client_secret,
      realm_id: realm_id,
      refresh_token: refresh_token,
      test: test
    )
  end
end

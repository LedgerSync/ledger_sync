require 'spec_helper'

support :netsuite_soap_helpers

RSpec.describe LedgerSync::Ledgers::NetSuiteSOAP::Client, type: :feature do
  include NetSuiteSOAPHelpers

  let(:client) { netsuite_soap_client }
end

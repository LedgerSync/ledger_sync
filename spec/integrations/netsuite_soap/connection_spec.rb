require 'spec_helper'

support :netsuite_soap_helpers

RSpec.describe LedgerSync::Ledgers::NetSuiteSOAP::Connection, type: :feature do
  include NetSuiteSOAPHelpers

  let(:connection) { netsuite_soap_connection }
end

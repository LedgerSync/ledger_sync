require 'spec_helper'

support :netsuite_soap_helpers

RSpec.describe LedgerSync::Adaptors::NetSuiteSOAP::Adaptor, type: :feature do
  include NetSuiteSOAPHelpers

  let(:adaptor) { netsuite_soap_adaptor }
end

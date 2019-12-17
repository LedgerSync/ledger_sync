require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Adaptor, type: :feature do
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor }
end

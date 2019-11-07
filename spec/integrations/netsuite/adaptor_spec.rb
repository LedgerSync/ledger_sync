require 'spec_helper'

support :adaptor_helpers
support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Adaptor, type: :feature do
  include AdaptorHelpers
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor }
end

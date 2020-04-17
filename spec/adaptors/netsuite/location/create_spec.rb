# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Adaptors::NetSuite::Location::Operations::Create do
  it_behaves_like 'a netsuite operation'
end

# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Ledgers::NetSuite::CustomerDeposit::Operations::Create do
  it_behaves_like 'a netsuite operation'
end

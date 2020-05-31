# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Customer::Operations::Find do
  it_behaves_like 'a netsuite operation'
end

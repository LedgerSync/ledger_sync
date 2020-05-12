# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Ledgers::NetSuite::Currency::Operations::Update do
  it_behaves_like 'a netsuite operation'
end

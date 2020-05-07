# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Adaptors::NetSuite::Department::Searcher do
  include NetSuiteHelpers

  it_behaves_like 'a netsuite searcher'
end

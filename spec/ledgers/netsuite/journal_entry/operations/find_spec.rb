# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Ledgers::NetSuite::JournalEntry::Operations::Find do
  it_behaves_like 'a netsuite operation'
end

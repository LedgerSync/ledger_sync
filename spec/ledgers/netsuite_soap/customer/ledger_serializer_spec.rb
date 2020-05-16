# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuiteSOAP::Customer::LedgerSerializer do
  let(:customer) { LedgerSync::Ledgers::NetSuiteSOAP::Customer.new }

  describe '#netsuite_lib_class' do
    it { expect(described_class.new(resource: customer).netsuite_lib_class).to eq(::NetSuite::Records::Customer) }
  end

  describe '.netsuite_lib_class' do
    it { expect(described_class.netsuite_lib_class).to eq(::NetSuite::Records::Customer) }
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Update do
  include TestAdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test') }

  it do
    instance = described_class.new(resource: customer, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end

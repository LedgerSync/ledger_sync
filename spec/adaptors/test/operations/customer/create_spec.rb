# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Create do
  include TestAdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(name: 'Test') }

  it do
    instance = described_class.new(resource: customer, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end

# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :stripe_helpers

RSpec.describe 'stripe/customers/find', type: :feature do
  include InputHelpers
  include StripeHelpers

  before { stub_customer_find }

  let(:resource) do
    create(
      :stripe_customer,
      external_id: :ext_id,
      ledger_id: 'cus_123',
      email: 'test@example.com',
      name: 'Sample Customer',
      phone_number: nil
    )
  end

  let(:input) do
    {
      client: stripe_client,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Ledgers::Stripe::Customer::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
    it { expect(subject.resource).to be_a(LedgerSync::Ledgers::Stripe::Customer) }
  end
end

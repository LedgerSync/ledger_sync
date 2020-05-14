require 'spec_helper'

support :stripe_helpers

RSpec.describe LedgerSync::Ledgers::Stripe::Client do
  include StripeHelpers

  let(:client) { stripe_client }

  describe '#url_for' do
    it do
      resource = LedgerSync::Ledgers::Stripe::Customer.new(ledger_id: 123)
      url = 'https://dashboard.stripe.com/customers/123'
      expect(client.url_for(resource: resource)).to eq(url)
    end

    it do
      expect { client.url_for(resource: nil) }.to raise_error(
        LedgerSync::Error::LedgerError::UnknownURLFormat
      )
    end
  end

  describe '.ledger_attributes_to_save' do
    it do
      expect(described_class.ledger_attributes_to_save).to eq([])
    end
  end
end

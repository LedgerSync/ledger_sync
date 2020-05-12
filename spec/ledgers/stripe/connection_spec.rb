require 'spec_helper'

support :stripe_helpers

RSpec.describe LedgerSync::Ledgers::Stripe::Connection do
  include StripeHelpers

  let(:connection) { stripe_connection }

  describe '#url_for' do
    it do
      resource = LedgerSync::Customer.new(ledger_id: 123)
      url = 'https://dashboard.stripe.com/customers/123'
      expect(connection.url_for(resource: resource)).to eq(url)
    end

    it do
      expect { connection.url_for(resource: nil) }.to raise_error(
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

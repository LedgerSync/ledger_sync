require 'spec_helper'

support :stripe_helpers

RSpec.describe LedgerSync::Adaptors::Stripe::Adaptor do
  include StripeHelpers

  let(:adaptor) { stripe_adaptor }

  describe '#url_for' do
    it do
      resource = LedgerSync::Customer.new(ledger_id: 123)
      url = 'https://dashboard.stripe.com/customers/123'
      expect(adaptor.url_for(resource: resource)).to eq(url)
    end

    it do
      expect { adaptor.url_for(resource: nil) }.to raise_error(
        LedgerSync::Error::AdaptorError::UnknownURLFormat
      )
    end
  end

  describe '.ledger_attributes_to_save' do
    it do
      expect(described_class.ledger_attributes_to_save).to eq([])
    end
  end
end

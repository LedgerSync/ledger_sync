# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::Stripe::Customer, adaptor: :stripe do
  let(:adaptor) { stripe_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{rand_id}"
    }
  end
  let(:resource) do
    FactoryBot.create(:customer)
  end

  it_behaves_like 'a full stripe resource'
end

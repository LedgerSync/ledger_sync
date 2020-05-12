# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::Stripe::Customer, qa: true, connection: :stripe do
  let(:connection) { stripe_connection }
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

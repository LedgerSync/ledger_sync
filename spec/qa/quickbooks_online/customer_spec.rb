# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer, qa: true, client: :quickbooks_online do
  let(:client) { quickbooks_online_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{rand_id}"
    }
  end
  let(:resource) { FactoryBot.create(:customer) }

  it_behaves_like 'a standard quickbooks_online resource'
end

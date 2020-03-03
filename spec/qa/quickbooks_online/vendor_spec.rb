# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Vendor, qa: true, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      display_name: "QA UPDATE #{rand_id}"
    }
  end
  let(:resource) { FactoryBot.create(:vendor) }

  it_behaves_like 'a standard quickbooks_online resource'
end

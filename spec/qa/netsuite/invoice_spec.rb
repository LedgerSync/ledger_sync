# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Invoice, qa: true, adaptor: :netsuite do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :invoice }
  let(:customer) { find_first_in_netsuite(resource_type: :customer) }
  let(:location) { find_first_in_netsuite(resource_type: :location) }
  let(:item) { find_first_in_netsuite(resource_type: :item) }
  let(:line_items) {
    FactoryBot.create_list(
      :invoice_sales_line_item,
      1,
      item: item
    )
  }
  let(:resource) do
    FactoryBot.create(
      :invoice,
      customer: customer,
      location: location,
      line_items: line_items
    )
  end

  it_behaves_like 'a full netsuite resource'
end

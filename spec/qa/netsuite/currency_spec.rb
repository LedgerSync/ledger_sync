# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Currency, qa: true, adaptor: :netsuite do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :currency }
  let(:resource) do
    FactoryBot.create(:currency)
  end

  it_behaves_like 'a full netsuite resource'
end

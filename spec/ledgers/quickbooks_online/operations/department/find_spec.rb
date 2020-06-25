# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:resource) do
    build(
      :quickbooks_online_department,
      ledger_id: '123',
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_department_find
end

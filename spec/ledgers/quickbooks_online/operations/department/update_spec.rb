# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:resource) do
    build(
      :quickbooks_online_department,
      ledger_id: '123',
      Name: 'Test Department',
      FullyQualifiedName: nil,
      Active: true,
      SubDepartment: false
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_department_find
                    stub_department_update
                  ]
end

# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:resource) do
    build(
      :quickbooks_online_ledger_class,
      Name: 'Test Class',
      FullyQualifiedName: nil,
      Active: true,
      SubClass: false
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_ledger_class_create
end

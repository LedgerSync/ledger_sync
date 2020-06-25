# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:account) do
    build(:quickbooks_online_account, ledger_id: '123')
  end
  let(:vendor) do
    build(:quickbooks_online_vendor, ledger_id: '123')
  end

  let(:department) do
    build(:quickbooks_online_department, ledger_id: '123')
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Bill.new(
      ledger_id: '123',
      account: account,
      department: department,
      vendor: vendor,
      reference_number: 'Ref123',
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      due_date: Date.new(2019, 9, 1),
      line_items: []
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: :stub_find_bill
end

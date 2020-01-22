# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Bill::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Account.new(
      ledger_id: '123',
      name: 'Test',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand'
    )
  end
  let(:vendor) do
    LedgerSync::Vendor.new(
      ledger_id: '123',
      first_name: 'Test',
      last_name: 'Testing'
    )
  end
  let(:resource) do
    LedgerSync::Bill.new(
      ledger_id: '123',
      account: account,
      vendor: vendor,
      reference_number: 'Ref123',
      currency: FactoryBot.create(
        :currency
      ),
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      due_date: Date.new(2019, 9, 1),
      line_items: []
    )
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: :stub_find_bill
end

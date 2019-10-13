require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/bills/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before {
    stub_find_bill
    stub_update_bill
  }

  # Account 1 needs to be Liability account
  let(:account1) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  # Account 2 needs to be different
  let(:account2) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:vendor) do
    LedgerSync::Vendor.new(vendor_resource({ledger_id: '123'}))
  end

  let(:line_item_1) do
    LedgerSync::BillLineItem.new(bill_line_item_resource({account: account2}))
  end

  let(:line_item_2) do
    LedgerSync::BillLineItem.new(bill_line_item_resource({account: account2}))
  end

  let(:resource) do
    LedgerSync::Bill.new(
      bill_resource(
        {
          ledger_id: '123',
          account: account1,
          vendor: vendor,
          line_items: [
            line_item_1,
            line_item_2
          ]
        }
      )
    )
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Bill::Operations::Update.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end

require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/invoices/upsert', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      external_id: :i1,
      method: :upsert,
      references: invoice_references
    }
  end

  xit { expect(LedgerSync::Sync.new(**input)).to be_valid }
  xit { expect(LedgerSync::Sync.new(**input).dry_run).to be_truthy }
  xit { expect(LedgerSync::Sync.new(**input).perform).to be_an(LedgerSync::OperationResult::Success) }
  xit { expect(LedgerSync::Sync.new(**input).perform).to be_success }
  xit { expect(LedgerSync::Sync.new(**input).perform.operation).to be_an(LedgerSync::Operation) }
  xit { expect(LedgerSync::Sync.new(**input).perform.value).to be_an(LedgerSync::Adaptors::QuickBooksOnline::Operations::Customer::Upsert) }
end

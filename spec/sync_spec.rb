require 'spec_helper'

support :adaptor_helpers, :input_helpers

RSpec.describe LedgerSync::Sync do
  include AdaptorHelpers
  include InputHelpers

  let(:input) do
    {
      adaptor: test_adaptor,
      resource_external_id: :c1,
      resource_type: 'customer',
      method: :create,
      resources_data: customer_resources
    }
  end

  let(:sync) { LedgerSync::Sync.new(**input) }

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }
  it { expect { sync.result }.to raise_error(LedgerSync::Error::SyncError::NotPerformedError) }

  it do
    expect(sync.perform).to be_success
    expect(sync.operations.first.result).to be_present
  end
end

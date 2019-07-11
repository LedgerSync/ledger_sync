require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Sync, type: :serializable do
  include AdaptorHelpers

  let(:adaptor) { test_adaptor }
  # let(:sync) do
  #   described_class.new(
  #     adaptor: adaptor,
  #     method: :upsert,
  #     resources_data: ,
  #     resource_external_id:,
  #     resource_type:
  #   )
  # end
end
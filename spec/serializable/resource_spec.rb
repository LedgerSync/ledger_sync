# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples

RSpec.describe LedgerSync::Resource, type: :serializable do
  let(:subsidiary) { LedgerSync::Ledgers::TestLedger::Subsidiary.new(name: 'Test Sub') }
  let(:customer) { new_resource }

  def new_resource
    LedgerSync::Ledgers::TestLedger::Customer.new(
      name: 'John Doe',
      email: 'test@test.com',
      subsidiary: subsidiary
    )
  end

  subject { customer.serialize }

  it_behaves_like 'a serializable object'
end

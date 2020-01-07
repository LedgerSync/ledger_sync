# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples,
        :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Create, type: :serializable do
  include TestAdaptorHelpers

  let(:adaptor) { test_adaptor }
  let(:resource) { LedgerSync::Customer.new(name: 'asdf') }
  let(:operation) { new_resource }

  def new_resource
    described_class.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Adaptors::Test::Expense::Operations::Find.new(
      adaptor: adaptor,
      resource: LedgerSync::Expense.new(transaction_date: Date.today)
    )
    expect(operation.send(:validation_data)[:transaction_date]).to be_a(Date)
  end

  it_behaves_like 'a serializable object'
end

# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create, type: :serializable do
  include QuickBooksOnlineHelpers

  let(:adaptor) { quickbooks_online_adaptor }
  let(:resource) { LedgerSync::Customer.new(name: 'asdf') }
  let(:operation) { new_resource }

  def new_resource
    described_class.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Find.new(
      adaptor: adaptor,
      resource: LedgerSync::Expense.new(transaction_date: Date.today)
    )
    expect(operation.send(:validation_data)[:transaction_date]).to be_a(Date)
  end

  it_behaves_like 'a serializable object'
end

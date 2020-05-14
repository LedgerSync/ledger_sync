# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create, type: :serializable do
  include QuickBooksOnlineHelpers

  let(:client) { quickbooks_online_client }
  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new(DisplayName: 'asdf') }
  let(:operation) { new_resource }

  def new_resource
    described_class.new(
      client: client,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Ledgers::QuickBooksOnline::Expense::Operations::Find.new(
      client: client,
      resource: LedgerSync::Ledgers::QuickBooksOnline::Expense.new(transaction_date: Date.today)
    )
    expect(operation.send(:validation_data)[:transaction_date]).to be_a(Date)
  end

  it_behaves_like 'a serializable object'
end

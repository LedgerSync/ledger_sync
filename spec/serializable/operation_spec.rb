# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create, type: :serializable do
  include QuickBooksOnlineHelpers

  let(:connection) { quickbooks_online_connection }
  let(:resource) { LedgerSync::Customer.new(name: 'asdf') }
  let(:operation) { new_resource }

  def new_resource
    described_class.new(
      connection: connection,
      resource: resource
    )
  end

  it 'does not serialize dates' do
    operation = LedgerSync::Ledgers::QuickBooksOnline::Expense::Operations::Find.new(
      connection: connection,
      resource: LedgerSync::Expense.new(transaction_date: Date.today)
    )
    expect(operation.send(:validation_data)[:transaction_date]).to be_a(Date)
  end

  it_behaves_like 'a serializable object'
end

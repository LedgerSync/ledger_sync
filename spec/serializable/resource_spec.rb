# frozen_string_literal: true

require 'spec_helper'

support :serializable_shared_examples

RSpec.describe LedgerSync::Resource, type: :serializable do
  let(:customer) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new(DisplayName: 'John Doe') }
  let(:payment) { new_resource }

  def new_resource
    LedgerSync::Ledgers::QuickBooksOnline::Payment.new(TotalAmt: 123, Customer: customer)
  end

  subject { payment.serialize }

  it_behaves_like 'a serializable object'
end

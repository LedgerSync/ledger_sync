require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Payment::Operations::Create do
  include TestAdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(name: 'Test')}
  let(:account) { LedgerSync::Account.new(name: 'Test')}
  let(:payment) do
    LedgerSync::Payment.new(
      amount: 12_345,
      currency: FactoryBot.create(:currency),
      reference_number: 'Ref123',
      memo: 'Memo',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01'),
      customer: customer,
      deposit_account: account,
      account: account,
      line_items: [],
    )
  end

  it do
    instance = described_class.new(resource: payment, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end

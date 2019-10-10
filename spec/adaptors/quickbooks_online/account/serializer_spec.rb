# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Serializer do
  let(:resource) do
    LedgerSync::Account.new(
      account_sub_type: account_sub_type,
      account_type: account_type,
      active: active,
      currency: currency,
      description: description,
      name: name,
      number: number
    )
  end
  let(:name) { 'account_name' }
  let(:account_type) { 'bank' }
  let(:account_sub_type) { 'cash_on_hand' }
  let(:number) { 123 }
  let(:currency) { 'USD' }
  let(:description) { 'A descirption' }
  let(:active) { true }

  let(:h) do
    {
      'Name' => name,
      'AccountType' => Mapping::ACCOUNT_TYPES[account_type],
      'AccountSubType' => Mapping::ACCOUNT_SUB_TYPES[account_sub_type],
      'AcctNum' => number,
      'CurrencyRef' => {
        'value' => currency
      },
      'Description' => description,
      'Active' => active
    }
  end

  describe '#to_h' do
    it do
      serializer = described_class.new(resource: resource)
      expect(serializer.to_h).to eq(h.reject { |e| e == 'Id' })
    end
  end

  describe '#deserialize' do
    let(:customer) { LedgerSync::Customer.new }

    it do
      expect_deserialized_attributes(
        attributes: %s[
          name,
          account_type,
          account_sub_type,
          number
          currency
          description
          active
        ],
        h: h,
        resource: resource,
        serializer_class: described_class
      )
    end
  end
end

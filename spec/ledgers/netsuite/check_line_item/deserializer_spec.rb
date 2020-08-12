# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::CheckLineItem::Deserializer do
  let(:account) do
    LedgerSync::Ledgers::NetSuite::Account.new(
      ledger_id: 'account_ledger_id'
    )
  end

  let(:department) do
    LedgerSync::Ledgers::NetSuite::Department.new(
      ledger_id: 'department_ledger_id'
    )
  end

  let(:ledger_class) do
    LedgerSync::Ledgers::NetSuite::LedgerClass.new(
      ledger_id: 'class_ledger_id'
    )
  end

  let(:resource) do
    LedgerSync::Ledgers::NetSuite::CheckLineItem.new(
      amount: 150.0,
      memo: 'This is memo',
      account: account,
      department: department,
      ledger_class: ledger_class
    )
  end

  let(:blank) do
    LedgerSync::Ledgers::NetSuite::CheckLineItem.new
  end

  let(:amount) { 150.0 }
  let(:memo) { 'This is memo' }

  let(:h) do
    {
      'amount' => amount,
      'memo' => memo,
      'account' => {
        'id' => account.ledger_id
      },
      'department' => {
        'id' => department.ledger_id
      },
      'class' => {
        'id' => ledger_class.ledger_id
      }
    }
  end

  describe '#deserialize' do
    it do
      deserializer = described_class.new
      expect(deserializer.deserialize(hash: h, resource: blank)).to eq(resource)
    end
  end
end

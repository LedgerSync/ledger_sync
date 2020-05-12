# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::DashboardURLHelper do
  let(:base_url) { 'https://www.example.com/' }
  let(:resource) { FactoryBot.create(resource_type, ledger_id: '123asdf') }

  let(:helper) { described_class.new(base_url: base_url, resource: resource) }
  let(:url) { helper.url }

  describe '#url' do
    context 'LedgerSync::Account' do
      let(:resource_type) { :account }

      it { expect(url).to eq('https://www.example.com/app/accounting/account/account.nl?id=123asdf') }
    end

    context 'LedgerSync::Currency' do
      let(:resource_type) { :currency }

      it { expect(url).to eq('https://www.example.com/app/common/multicurrency/currency.nl?id=123asdf') }
    end

    context 'LedgerSync::Customer' do
      let(:resource_type) { :customer }

      it { expect(url).to eq('https://www.example.com/app/common/entity/entity.nl?id=123asdf') }
    end

    context 'LedgerSync::Vendor' do
      let(:resource_type) { :vendor }

      it { expect(url).to eq('https://www.example.com/app/common/entity/entity.nl?id=123asdf') }
    end

    context 'LedgerSync::Department' do
      let(:resource_type) { :department }

      it { expect(url).to eq('https://www.example.com/app/common/otherlists/departmenttype.nl?id=123asdf') }
    end

    context 'LedgerSync::Deposit' do
      let(:resource_type) { :deposit }

      it { expect(url).to eq('https://www.example.com/app/accounting/transactions/transaction.nl?id=123asdf') }
    end

    context 'LedgerSync::Invoice' do
      let(:resource_type) { :invoice }

      it { expect(url).to eq('https://www.example.com/app/accounting/transactions/transaction.nl?id=123asdf') }
    end
  end
end

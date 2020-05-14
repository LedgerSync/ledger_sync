# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::DashboardURLHelper do
  let(:base_url) { 'https://www.example.com/' }
  let(:resource) { FactoryBot.create(resource_type, ledger_id: '123asdf') }

  let(:helper) { described_class.new(base_url: base_url, resource: resource) }
  let(:url) { helper.url }

  describe '#url' do
    context 'Account' do
      let(:resource_type) { :netsuite_account }

      it { expect(url).to eq('https://www.example.com/app/accounting/account/account.nl?id=123asdf') }
    end

    context 'Currency' do
      let(:resource_type) { :netsuite_currency }

      it { expect(url).to eq('https://www.example.com/app/common/multicurrency/currency.nl?id=123asdf') }
    end

    context 'Customer' do
      let(:resource_type) { :netsuite_customer }

      it { expect(url).to eq('https://www.example.com/app/common/entity/entity.nl?id=123asdf') }
    end

    context 'Vendor' do
      let(:resource_type) { :netsuite_vendor }

      it { expect(url).to eq('https://www.example.com/app/common/entity/entity.nl?id=123asdf') }
    end

    context 'Department' do
      let(:resource_type) { :netsuite_department }

      it { expect(url).to eq('https://www.example.com/app/common/otherlists/departmenttype.nl?id=123asdf') }
    end

    context 'Deposit' do
      let(:resource_type) { :netsuite_deposit }

      it { expect(url).to eq('https://www.example.com/app/accounting/transactions/transaction.nl?id=123asdf') }
    end

    context 'Invoice' do
      let(:resource_type) { :netsuite_invoice }

      it { expect(url).to eq('https://www.example.com/app/accounting/transactions/transaction.nl?id=123asdf') }
    end
  end
end

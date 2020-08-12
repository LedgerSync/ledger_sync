# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::BillPayment, qa: true, client: :quickbooks_online do
  let(:client) { quickbooks_online_client }
  let(:attribute_updates) do
    {
      PrivateNote: "QA UPDATE #{rand_id}"
    }
  end

  let(:account) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_account,
        AcctNum: rand(10_000).to_s,
        AccountType: 'bank',
        Classification: 'asset',
        AccountSubType: 'cash_on_hand'
      )
    )
  end

  let(:account_expense) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_account,
        AcctNum: rand(10_000).to_s,
        AccountType: 'expense',
        Classification: 'expense',
        AccountSubType: 'advertising_promotional'
      )
    )
  end

  let(:account_payable) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_account,
        AcctNum: rand(10_000).to_s,
        AccountType: 'accounts_payable',
        Classification: 'liability',
        AccountSubType: 'accounts_payable'
      )
    )
  end

  let(:account_credit_card) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_account,
        AcctNum: rand(10_000).to_s,
        AccountType: 'credit_card',
        Classification: 'liability',
        AccountSubType: 'credit_card'
      )
    )
  end

  let(:vendor) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_vendor,
        PrimaryEmailAddr: build(
          :quickbooks_online_primary_email_addr,
          Address: "test-#{rand(1000)}@example.com"
        ),
        PrimaryPhone: build(
          :quickbooks_online_primary_phone,
          FreeFormNumber: "+1#{rand(9_999_999_99)}"
        )
      )
    )
  end

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:department) do
    create_resource_for(
      client: client,
      resource: build(:quickbooks_online_department)
    )
  end

  let(:bill) do
    create_resource_for(
      client: client,
      resource: build(
        :quickbooks_online_bill,
        Currency: currency,
        APAccount: account_payable,
        Vendor: vendor,
        Department: department,
        DocNumber: "Doc##{rand(100_00)}",
        Line: [
          build(
            :quickbooks_online_bill_line,
            AccountBasedExpenseLineDetail: build(
              :quickbooks_online_account_based_expense_line_detail,
              Account: account_expense
            ),
            Amount: 100
          )
        ]
      )
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_bill_payment,
      APAccount: account,
      Currency: currency,
      Department: department,
      Vendor: vendor,
      PayType: 'credit_card',
      DocNumber: "Doc##{rand(100_00)}",
      CreditCardPayment: build(
        :quickbooks_online_credit_card_payment,
        CCAccount: account_credit_card
      ),
      CheckPayment: nil,
      Line: [
        build(
          :quickbooks_online_bill_payment_line,
          Amount: 100,
          LinkedTxn: [bill]
        )
      ]
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense, qa: true, client: :quickbooks_online do
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

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_expense,
      Account: account,
      DocNumber: "Doc##{rand(100_00)}",
      Currency: currency,
      Line: [
        build(
          :quickbooks_online_expense_line,
          AccountBasedExpenseLineDetail: build(
            :quickbooks_online_account_based_expense_line_detail,
            Account: account
          )
        ),
        build(
          :quickbooks_online_expense_line,
          AccountBasedExpenseLineDetail: build(
            :quickbooks_online_account_based_expense_line_detail,
            Account: account
          )
        )
      ]
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end

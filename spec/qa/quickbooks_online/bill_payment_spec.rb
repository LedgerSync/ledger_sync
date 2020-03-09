# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::BillPayment, qa: true, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{rand_id}"
    }
  end

  let(:account) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(:account)
    )
  end

  let(:account_expense) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(
        :account,
        account_type: 'expense',
        classification: 'expense',
        account_sub_type: 'advertising_promotional'
      )
    )
  end

  let(:account_payable) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(
        :account,
        account_type: 'accounts_payable',
        classification: 'liability',
        account_sub_type: 'accounts_payable'
      )
    )
  end

  let(:account_credit_card) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(
        :account,
        account_type: 'credit_card',
        classification: 'liability',
        account_sub_type: 'credit_card'
      )
    )
  end

  let(:vendor) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(:vendor)
    )
  end

  let(:currency) { build(:currency, name: 'United States Dollar', symbol: 'USD') }

  let(:department) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(:department)
    )
  end

  let(:bill) do
    create_resource_for(
      adaptor: adaptor,
      resource: FactoryBot.create(
        :bill,
        currency: currency,
        account: account_payable,
        vendor: vendor,
        department: department,

        line_items: [
          FactoryBot.create(
            :bill_line_item,
            account: account_expense,
            amount: 100
          )
        ]
      )
    )
  end

  let(:resource) do
    FactoryBot.create(
      :bill_payment,
      account: account,
      currency: currency,
      department: department,
      vendor: vendor,

      payment_type: 'credit_card',
      credit_card_account: account_credit_card,

      line_items: [
        FactoryBot.create(
          :bill_payment_line_item,
          amount: 100,
          ledger_transactions: [bill]
        )
      ]
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end

# frozen_string_literal: true

support :adaptor_helpers,
        :quickbooks_online_shared_examples

module QuickBooksOnlineHelpers
  include AdaptorHelpers

  module Resources
    include AdaptorHelpers

    module_function

    def account
      LedgerSync::Account.new(
        name: "Test Account #{test_run_id}",
        classification: 'asset',
        account_type: 'bank',
        account_sub_type: 'cash_on_hand',
        currency: 'usd',
        description: "Test #{test_run_id} Account description",
        active: true
      )
    end

    def expense
      LedgerSync::Expense.new(
        currency: 'usd',
        memo: 'Testing',
        payment_type: 'cash',
        transaction_date: Date.today,
        exchange_rate: 1.0,
        entity: vendor,
        account: account,
        line_items: [
          expense_line_item_1,
          expense_line_item_2
        ]
      )
    end

    def vendor
      LedgerSync::Vendor.new(
        company_name: "#{test_run_id} Company",
        email: "test-#{test_run_id}-vendor@example.com",
        first_name: "TestFirst#{test_run_id}",
        last_name: "TestLast#{test_run_id}",
        display_name: "Test #{test_run_id} Display Name"
      )
    end
  end

  def adaptor_class
    LedgerSync::Adaptors::QuickBooksOnline::Adaptor
  end

  def quickbooks_online_adaptor
    @quickbooks_online_adaptor ||= LedgerSync.adaptors.quickbooks_online.new_from_env(test: true)
  end
end

RSpec.configure do |config|
  config.include QuickBooksOnlineHelpers, adaptor: :quickbooks_online
  # config.before { quickbooks_online_adaptor.refresh! }
  config.around do |example|
    example.run
  ensure
    quickbooks_online_adaptor.update_secrets_in_dotenv
  end
end

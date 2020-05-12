# frozen_string_literal: true

qa_support :ledger_helpers,
           :stripe_shared_examples

module QA
  module StripeHelpers
    include LedgerHelpers

    def connection_class
      LedgerSync::Ledgers::Stripe::Connection
    end

    def stripe_connection
      @stripe_connection ||= LedgerSync.ledgers.stripe.new(
        api_key: ENV.fetch('STRIPE_API_KEY')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::StripeHelpers, qa: true, connection: :stripe
end

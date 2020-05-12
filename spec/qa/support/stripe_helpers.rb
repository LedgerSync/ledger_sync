# frozen_string_literal: true

qa_support :ledger_helpers,
           :stripe_shared_examples

module QA
  module StripeHelpers
    include LedgerHelpers

    def client_class
      LedgerSync::Ledgers::Stripe::Client
    end

    def stripe_client
      @stripe_client ||= LedgerSync.ledgers.stripe.new(
        api_key: ENV.fetch('STRIPE_API_KEY')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::StripeHelpers, qa: true, client: :stripe
end

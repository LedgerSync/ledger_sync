# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :stripe_shared_examples

module QA
  module StripeHelpers
    include LedgerSync::Test::QA::LedgerHelpers

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

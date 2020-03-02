# frozen_string_literal: true

qa_support :adaptor_helpers,
           :stripe_shared_examples

module QA
  module StripeHelpers
    include AdaptorHelpers

    def adaptor_class
      LedgerSync::Adaptors::Stripe::Adaptor
    end

    def stripe_adaptor
      @stripe_adaptor ||= LedgerSync.adaptors.stripe.new(
        api_key: ENV.fetch('STRIPE_API_KEY')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::StripeHelpers, qa: true, adaptor: :stripe
end

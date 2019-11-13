# frozen_string_literal: true

LedgerSync.register_adaptor(:stripe) do |config|
  config.name = 'Stripe'
  config.rate_limiting_wait_in_seconds = 60
end

# frozen_string_literal: true

LedgerSync.register_client(:stripe) do |config|
  config.name = 'Stripe'
end

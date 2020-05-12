# frozen_string_literal: true

LedgerSync.register_connection(:stripe) do |config|
  config.name = 'Stripe'
end

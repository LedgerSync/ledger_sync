# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CreditCardPayment
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :CCAccount,
                         hash_attribute: 'CCAccountRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end

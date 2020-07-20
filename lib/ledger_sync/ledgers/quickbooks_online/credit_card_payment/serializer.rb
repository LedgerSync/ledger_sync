# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CreditCardPayment
        class Serializer < QuickBooksOnline::Serializer
          references_one 'CCAccountRef',
                         resource_attribute: :CCAccount,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end

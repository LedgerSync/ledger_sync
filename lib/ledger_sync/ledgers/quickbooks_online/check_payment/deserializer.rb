# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CheckPayment
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :BankAccount,
                         hash_attribute: 'BankAccountRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CheckPayment
        class Serializer < QuickBooksOnline::Serializer
          references_one 'BankAccountRef',
                         resource_attribute: :BankAccount,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'ledger_sync/adaptors/serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Serializer < Adaptors::Serializer
        # This is where we can do adaptor-specific conversions
        # (e.g. date string representation)
      end
    end
  end
end
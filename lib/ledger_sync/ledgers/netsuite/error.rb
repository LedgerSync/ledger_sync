# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Error < LedgerSync::Error
        class SubsidiariesNotEnabled < self
          def initialize(message: nil)
            message ||= 'Subsidiaries are not enabled on this account'

            super(
              message: message
            )
          end
        end
      end
    end
  end
end

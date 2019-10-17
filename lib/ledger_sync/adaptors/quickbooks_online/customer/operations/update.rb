# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end

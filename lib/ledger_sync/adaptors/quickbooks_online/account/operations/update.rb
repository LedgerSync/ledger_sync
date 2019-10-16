# frozen_string_literal: true

# https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/account
# Requires full update
module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
                required(:account_sub_type).filled(:string)
                required(:number).maybe(:integer)
                required(:currency).maybe(:string)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end
          end
        end
      end
    end
  end
end
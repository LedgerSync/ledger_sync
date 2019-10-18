# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:ledger_id).maybe(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash do
                  required(:object).filled(:symbol)
                  required(:id).filled(:string)
                end
              end
            end
          end
        end
      end
    end
  end
end

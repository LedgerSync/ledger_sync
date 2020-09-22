# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Contact
        module Operations
          class Create < Xero::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:Name).maybe(:string)
                required(:EmailAddress).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end

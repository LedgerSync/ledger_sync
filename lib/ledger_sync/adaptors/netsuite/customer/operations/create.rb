# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
                required(:subsidiary).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).filled(:string)
                required(:ledger_id).filled(:string)
                required(:display_name).filled(:string)
                required(:first_name).filled(:string)
                required(:last_name).filled(:string)
                required(:email).filled(:string)
                required(:company_name).filled(:string)
                required(:phone_number).filled(:string)
                required(:subsidiary).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:display_name).maybe(:string)
                required(:first_name).maybe(:string)
                required(:last_name).maybe(:string)
                optional(:email).maybe(:string)
                optional(:company_name).maybe(:string)
                optional(:phone_number).maybe(:string)
                optional(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

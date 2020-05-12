# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Vendor
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:company_name).filled(:string)
                required(:display_name).filled(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
                optional(:phone_number).maybe(:string)
                required(:subsidiary).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

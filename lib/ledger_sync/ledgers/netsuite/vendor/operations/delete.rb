# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Vendor
        module Operations
          class Delete < NetSuite::Operation::Delete
            class Contract < LedgerSync::Ledgers::Contract
              params do
                optional(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:company_name).maybe(:string)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
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

# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Vendor
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
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

# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end

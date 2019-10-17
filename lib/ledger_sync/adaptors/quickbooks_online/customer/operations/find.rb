module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end

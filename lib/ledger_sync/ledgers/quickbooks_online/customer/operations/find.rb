module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Customer
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
                required(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

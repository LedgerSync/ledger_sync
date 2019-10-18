module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:amount).maybe(:integer)
                optional(:currency).maybe(:string)
                optional(:customer).maybe(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

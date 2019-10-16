module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Transfer
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).maybe(:integer)
                required(:currency).maybe(:string)
                required(:memo).maybe(:string)
                required(:transaction_date).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end

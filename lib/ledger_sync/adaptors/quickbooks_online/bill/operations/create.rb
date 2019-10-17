module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:vendor).hash(Types::Reference)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).maybe(:string)
                required(:transaction_date).maybe(:date?)
                required(:due_date).maybe(:date?)
                required(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:due_date).maybe(:date?)
                required(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                required(:memo).maybe(:string)
                required(:reference_number).maybe(:string)
                required(:transaction_date).maybe(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

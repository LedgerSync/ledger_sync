module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:currency).filled(:string)
                optional(:due_date).maybe(:date?)
                optional(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).maybe(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

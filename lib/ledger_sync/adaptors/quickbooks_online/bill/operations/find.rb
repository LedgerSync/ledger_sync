module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:currency).maybe(:string)
                optional(:due_date).maybe(:date?)
                optional(:line_items).array(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:memo).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).maybe(:date?)
                optional(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

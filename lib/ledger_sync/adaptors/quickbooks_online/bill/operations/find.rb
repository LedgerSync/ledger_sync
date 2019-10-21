module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:account).hash(Types::Reference)
                required(:currency).maybe(:string)
                required(:due_date).maybe(:date?)
                required(:line_items).array(Types::Reference)
                required(:ledger_id).filled(:string)
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

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
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

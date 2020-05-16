module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:payment_type).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).filled(:date?)
                optional(:entity).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

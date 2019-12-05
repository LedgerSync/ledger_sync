module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Department
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:active).filled(:bool?)
                required(:sub_department).filled(:bool?)
                optional(:fully_qualified_name).maybe(:string)
                optional(:parent).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                optional(:active).maybe(:bool?)
                optional(:sub_department).maybe(:bool?)
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

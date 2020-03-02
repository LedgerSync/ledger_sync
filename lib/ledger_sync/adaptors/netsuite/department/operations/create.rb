# frozen_string_literal: true

# require_relative '../../operation/create'

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).value(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end

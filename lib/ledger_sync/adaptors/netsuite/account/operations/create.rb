# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:classification).maybe(:string)
                required(:account_type).maybe(:string)
                required(:account_sub_type).maybe(:string)
                required(:number).filled(:integer)
                required(:currency).filled(:hash, Types::Reference)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end
          end
        end
      end
    end
  end
end

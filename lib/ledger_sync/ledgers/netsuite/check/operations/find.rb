# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:memo).maybe(:string)
                required(:trandate).maybe(:string)
                required(:account).maybe(:hash, Types::Reference)
                required(:department).maybe(:hash, Types::Reference)
                required(:entity).maybe(:hash, Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                required(:line_items).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:memo).maybe(:string)
                required(:trandate).maybe(:string)
                required(:account).filled(:hash, Types::Reference)
                required(:department).filled(:hash, Types::Reference)
                required(:entity).filled(:hash, Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

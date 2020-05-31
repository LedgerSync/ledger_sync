# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:memo).maybe(:string)
                required(:trandate).maybe(:date?)
                required(:tranId).maybe(:string)
                required(:currency).maybe(:hash, Types::Reference)
                required(:subsidiary).maybe(:hash, Types::Reference)
                required(:line_items).array(Types::Reference)
              end
            end

            def request_params
              super.merge({ replace: 'line' })
            end
          end
        end
      end
    end
  end
end

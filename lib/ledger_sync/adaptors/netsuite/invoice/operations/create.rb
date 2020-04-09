# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:currency).maybe(:hash, Types::Reference)
                required(:customer).hash(Types::Reference)
                optional(:deposit).maybe(:integer)
                required(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                required(:location).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:transaction_date).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        module Operations
          class Delete < NetSuite::Operation::Delete
            class Contract < LedgerSync::Adaptors::Contract
              params do
                optional(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:currency).filled(:hash, Types::Reference)
                optional(:customer).hash(Types::Reference)
                optional(:deposit).maybe(:integer)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:location).array(Types::Reference)
                optional(:memo).filled(:string)
                optional(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end

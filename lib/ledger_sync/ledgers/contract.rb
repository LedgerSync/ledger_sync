# frozen_string_literal: true

module LedgerSync
  module Ledgers
    class Contract < Dry::Validation::Contract
      module Types
        include Dry::Types()

        Reference = Dry::Schema.Params do
          required(:object).filled(eql?: :reference)
          required(:id).filled(:string)
        end
      end
    end
  end
end

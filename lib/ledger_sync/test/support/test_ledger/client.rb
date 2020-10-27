# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Client
        include Ledgers::Client::Mixin

        attr_reader :api_key

        def initialize(args = {})
          @api_key = args.fetch(:api_key)
        end

        def self.ledger_attributes_to_save
          %i[api_key]
        end
      end
    end
  end
end

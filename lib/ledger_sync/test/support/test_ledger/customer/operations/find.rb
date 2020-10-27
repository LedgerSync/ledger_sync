# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer
        module Operations
          class Find < TestLedger::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:name).maybe(:string)
                required(:email).filled(:string)
                required(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end

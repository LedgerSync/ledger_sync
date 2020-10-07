# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module TestLedger
      class Operation
        class Create
          include TestLedger::Operation::Mixin

          private

          def operate
            success(
              resource: TestLedger::Customer.new(
                name: 'New Name',
                email: 'new@example.com'
              ),
              response: response
            )
          end
        end
      end
    end
  end
end

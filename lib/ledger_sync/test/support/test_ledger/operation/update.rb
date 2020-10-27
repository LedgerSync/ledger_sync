# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module TestLedger
      class Operation
        class Update
          include TestLedger::Operation::Mixin

          private

          def operate
            success(
              resource: resource.dup.assign_attributes(name: 'New Name'),
              response: response
            )
          end
        end
      end
    end
  end
end

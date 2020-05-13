# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module Stripe
      class Operation
        class Delete
          include Stripe::Operation::Mixin

          private
        end
      end
    end
  end
end

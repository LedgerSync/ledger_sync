# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module Stripe
      class Operation
        class Find
          include Stripe::Operation::Mixin
        end
      end
    end
  end
end

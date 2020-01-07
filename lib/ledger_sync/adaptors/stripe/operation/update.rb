# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module Stripe
      module Operation
        class Update
          include Stripe::Operation::Mixin

          private
        end
      end
    end
  end
end

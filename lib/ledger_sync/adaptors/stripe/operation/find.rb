# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module Stripe
      module Operation
        class Find
          include Stripe::Operation::Mixin
        end
      end
    end
  end
end

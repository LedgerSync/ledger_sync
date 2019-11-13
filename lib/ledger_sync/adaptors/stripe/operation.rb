# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Stripe
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def perform
              ::Stripe.api_key = adaptor.api_key
              ret = super
              ::Stripe.api_key = nil
              ret
            end

            def stripe_resource_type
              @stripe_resource_type ||= ledger_serializer.class.stripe_resource_type
            end
          end
        end
      end
    end
  end
end

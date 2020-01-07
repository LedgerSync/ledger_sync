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
            def stripe_resource_type
              @stripe_resource_type ||= ledger_serializer.class.stripe_resource_type
            end

            def perform
              adaptor.wrap_perform do
                super
              end
            rescue ::Stripe::StripeError => e
              case e.code
              when 'resource_missing'
                failure(e)
              else
                raise e
              end
            end
          end
        end
      end
    end
  end
end

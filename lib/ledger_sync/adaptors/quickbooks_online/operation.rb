# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def perform
              super
            rescue OAuth2::Error => e
              failure(e)
            end

            def quickbooks_online_resource_type
              @quickbooks_online_resource_type ||= ledger_serializer.class.quickbooks_online_resource_type
            end
          end
        end
      end
    end
  end
end

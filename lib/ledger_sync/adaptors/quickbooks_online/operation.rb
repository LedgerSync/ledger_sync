# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
          end

          def perform
            super
          rescue OAuth2::Error => e
            failure(e)
          end

          def quickbooks_online_resource_type
            resource.class.resource_type
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferClientMixin
        module ClassMethods
          def inferred_client_class
            @inferred_client_class ||= begin
              return if name.nil?

              parts = name.split('::')
              return unless parts.include?('Ledgers')

              LedgerSync::Ledgers.const_get(
                parts[parts.index('Ledgers') + 1]
              )::Client
            end
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end

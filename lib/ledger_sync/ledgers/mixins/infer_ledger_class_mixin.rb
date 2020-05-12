# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferLedgerClassMixin
        module ClassMethods
          def inferred_connection_class
            @inferred_connection_class ||= begin
              parts = name.split('::')
              LedgerSync::Ledgers.const_get(
                parts[parts.index('Ledgers') + 1]
              )::Connection
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

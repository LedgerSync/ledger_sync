# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferLedgerClassMixin
        module ClassMethods
          def inferred_client_class
            @inferred_client_class ||= begin
              parts = name.split('::')
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

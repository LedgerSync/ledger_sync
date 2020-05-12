# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferResourceClassMixin
        module ClassMethods
          def inferred_resource_class
            @inferred_resource_class ||= begin
              parts = name.split('::')
              LedgerSync.const_get(parts[parts.index('Ledgers') + 2])
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

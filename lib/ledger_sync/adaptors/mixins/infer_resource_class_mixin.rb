# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Mixins
      module InferResourceClassMixin
        module ClassMethods
          def inferred_resource_class
            @inferred_resource_class ||= begin
              parts = name.split('::')
              LedgerSync.const_get(parts[parts.index('Adaptors') + 2])
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

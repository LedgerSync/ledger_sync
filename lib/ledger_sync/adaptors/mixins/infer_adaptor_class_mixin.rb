# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Mixins
      module InferAdaptorClassMixin
        module ClassMethods
          def inferred_adaptor_class
            @inferred_adaptor_class ||= begin
              parts = name.split('::')
              LedgerSync::Adaptors.const_get(
                parts[parts.index('Adaptors') + 1]
              )::Adaptor
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

# frozen_string_literal: true

require_relative 'infer_client_mixin'

module LedgerSync
  module Ledgers
    module Mixins
      module InferResourceClassMixin
        module ClassMethods
          def inferred_resource_class
            @inferred_resource_class ||= begin
              parts = name.split('::')

              inferred_client_class.base_module.const_get(
                parts[parts.index('Ledgers').to_i + 2]
              )
            end
          end
        end

        def self.included(base)
          base.include InferClientMixin
          base.extend ClassMethods
        end
      end
    end
  end
end

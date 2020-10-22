# frozen_string_literal: true

require_relative 'infer_client_mixin'

module LedgerSync
  module Ledgers
    module Mixins
      module InferResourceClassMixin
        module ClassMethods
          def inferred_resource_class
            @inferred_resource_class ||= begin
              base = inferred_client_class.base_module
              part_name = (
                name.split('::') - base.to_s.split('::')
              ).first

              base.const_get(part_name)
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

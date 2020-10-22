# frozen_string_literal: true

require_relative 'infer_config_mixin'

module LedgerSync
  module Ledgers
    module Mixins
      module InferResourceClassMixin
        module ClassMethods
          def inferred_resource_class
            @inferred_resource_class ||= begin
              base_module = inferred_config.base_module

              base_module.const_get(name.split(base_module.name).last.split('::')[1])
            end
          end
        end

        def self.included(base)
          base.include InferConfigMixin
          base.extend ClassMethods
        end
      end
    end
  end
end

# frozen_string_literal: true

module LedgerSync
  module Util
    module Mixins
      module ResourceRegisterableMixin
        module ClassMethods
          def register_resource(resource:)
            if resources.is_a?(Hash)
              raise "Resource key #{resource.resource_type} already exists." if resources.key?(resource.resource_type)

              resources[resource.resource_type] = resource
            else
              resources << resource
            end
          end

          def resources
            @resources ||= []
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end

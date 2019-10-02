# frozen_string_literal: true

# Helper methods for adding dirty tracked attributes
module LedgerSync
  class ResourceAttribute
    module DirtyMixin
      def self.included(base)
        base.include(ActiveModel::Dirty)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def dirty_attribute(*names)
          names.each do |name|
            class_eval do
              attr_reader name
              define_attribute_methods name # From ActiveModel
              dirty_attributes[name] = {
                name: name
              }

              define_method("#{name}=") do |val|
                send("#{name}_will_change!") unless val == instance_variable_get("@#{name}")
                instance_variable_set("@#{name}", val)
              end
            end
          end
        end

        def dirty_attributes
          @dirty_attributes ||= {}
        end
      end

      def save
        changes_applied
      end
    end
  end
end

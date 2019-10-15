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

      def changed?
        resource_attributes.references_many do |resource_attribute|
          return true if resource_attribute.value.changed?
        end

        super
      end

      def changes
        pdb
        super.merge(Hash[resource_attributes.references_many.map { |ref| [ref.name, ref.value.value_changes] if ref.changed? }.compact])
      end

      # Change the dirty change set of {"name" => ["Bill", "Bob"]}
      # to current values of attributes that have changed: {"name" => "Bob"}
      def changes_to_h
        Hash[changes.map { |k, v| [k, v.last] }]
      end

      def dirty_attributes_to_h
        Hash[self.class.dirty_attributes.keys.map do |k|
          [
            k,
            public_send(k)
          ]
        end]
      end

      # Normally you would just call `changes_applied`, but because we
      # define an `@attributes` instance variable, the `ActiveModel::Dirty`
      # mixin assumes it is a list of attributes in their format (spoiler: it
      # isn't).  So this is copying the code from `changes_applied` and setting
      # `@mutations_from_database` to the value it would receive if
      # `@attributes` did not exist.
      def save
        # changes_applied # Code reproduced below.
        @mutations_before_last_save = mutations_from_database
        # forget_attribute_assignments # skipped as our attributes do not implement this method
        @mutations_from_database = ActiveModel::ForcedMutationTracker.new(self) # Manually set to expected value
      end
    end
  end
end

module LedgerSync
  module Util
    class Coordinator
      attr_reader :operation

      def initialize(operation:)

        @operation = operation
      end

      def operations
        @operations ||= begin
          flattened_operation = self.class.flatten_operation(
            operation
          )

          converted_operations = self.class.convert_downstream_creates_to_upserts(
            flattened_operation
          )

          de_duped = self.class.de_dup(converted_operations)

          de_duped
        end
      end

      # If we have already seen a create for the same object
      def self.convert_downstream_creates_to_upserts(ops)
        cache = {}
        ops.flat_map do |op|
          cache_key = "#{op.class.name}/#{op.resource.external_id}"
          if op.create? && cache.key?(cache_key)
            flatten_operation(op.convert_to_update)
          else
            cache[cache_key] = nil
            op
          end
        end
      end

      def self.de_dup(ops)
        @de_dup_cache = {}

        ops.select do |op|
          cache_key = "#{op.class.name}/#{op.resource.external_id}/#{op.fingerprint}"

          if @de_dup_cache.key?(cache_key)
            false
          else
            @de_dup_cache[cache_key] = true
          end
        end
      end

      # To build the ordered operations, start at root operation,
      # perform all before_operations in order, perform root,
      # then perform all after_operations in order,
      # recursively doing the same for all operations.
      def self.flatten_operation(op)
        op.prepare

        raise "root_operation required: #{op.inspect}" if op.root_operation.nil?

        [
          op.before_operations.map { |e| flatten_operation(e) },
          op.root_operation,
          op.after_operations.map { |e| flatten_operation(e) }
        ].flatten
      end
    end
  end
end

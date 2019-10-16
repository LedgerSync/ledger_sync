require 'json'
# Inspired by
# https://github.com/rails/rails/blob/v6.0.0/activesupport/lib/active_support/core_ext/hash/keys.rb#L116

module LedgerSync
  module Util
    module HashHelpers
      module_function

      def deep_merge(hash_to_merge_into:, other_hash:, &block)
        hash_to_merge_into.merge(other_hash) do |key, this_val, other_val|
          if this_val.is_a?(Hash) && other_val.is_a?(Hash)
            deep_merge(hash_to_merge_into: this_val, other_hash: other_val, &block)
          elsif block_given?
            block.call(key, this_val, other_val)
          else
            other_val
          end
        end
      end

      def deep_symbolize_keys(hash)
        deep_transform_keys_in_object(hash) { |key| key.to_sym rescue key }
      end

      def deep_transform_keys_in_object(object, &block)
        case object
        when Hash
          object.each_with_object({}) do |(key, value), result|
            result[yield(key)] = deep_transform_keys_in_object(value, &block)
          end
        when Array
          object.map { |e| deep_transform_keys_in_object(e, &block) }
        else
          object
        end
      end

      def deep_stringify_keys(hash)
        deep_transform_keys_in_object(hash) { |key| key.to_s rescue key }
      end
    end
  end
end

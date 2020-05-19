# frozen_string_literal: true

module LedgerSync
  module Util
    module Mixins
      module DelegateIterableMethodsMixin
        module ClassMethods
          SHARED_METHODS = %i[
            []
            any?
            count
            each
            empty?
            include?
            map
          ].freeze

          ARRAY_METHODS = (SHARED_METHODS | %i[]).freeze

          HASH_METHODS = (SHARED_METHODS | %i[
            each_value
            fetch
            key?
            keys
            values
          ]).freeze

          def delegate_array_methods_to(delegate_to)
            delegate(*ARRAY_METHODS, to: delegate_to)
          end

          def delegate_hash_methods_to(delegate_to)
            delegate(*HASH_METHODS, to: delegate_to)
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end

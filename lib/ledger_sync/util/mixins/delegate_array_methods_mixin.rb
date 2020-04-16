# frozen_string_literal: true

module LedgerSync
  module Util
    module Mixins
      module DelegateArrayMethodsMixin
        module ClassMethods
          def delegate_array_methods_to(attr)
            delegate :[],
                    :any?,
                    :count,
                    :each,
                    :empty?,
                    :include?,
                    :key?,
                    :keys,
                    :map,
                    to: attr
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end
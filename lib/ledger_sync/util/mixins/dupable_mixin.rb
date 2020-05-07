# frozen_string_literal: true

module LedgerSync
  module Util
    module Mixins
      module DupableMixin
        def dup
          Marshal.load(Marshal.dump(self))
        end
      end
    end
  end
end

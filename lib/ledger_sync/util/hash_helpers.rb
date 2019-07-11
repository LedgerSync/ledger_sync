require 'json'

module LedgerSync
  module Util
    module HashHelpers
      module_function

      def deep_symbolize_keys(hash)
        JSON.parse(JSON[hash], symbolize_names: true)
      end
    end
  end
end

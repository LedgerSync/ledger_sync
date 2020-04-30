# frozen_string_literal: true

module LedgerSync
  class Serialization
    class DeserializerDelegator
      def deserialize(args = {})
        deserializer_for(args).new.deserialize(args)
      end

      private

      def deserializer_for(_args = {})
        raise NotImplementedError
      end
    end
  end
end

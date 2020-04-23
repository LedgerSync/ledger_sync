# frozen_string_literal: true

module LedgerSync
  class Serialization
    class Delegator

      def serialize(args = {})
        serializer_for(args).new.serialize(args)
      end

      private

      def serializer_for(args = {})
        raise NotImplementedError
      end
    end
  end
end

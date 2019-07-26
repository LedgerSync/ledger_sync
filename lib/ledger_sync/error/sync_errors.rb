# frozen_string_literal: true

module LedgerSync
  class Error
    class SyncError < Error
      attr_reader :sync

      def initialize(message:, sync:)
        @sync = sync
        super(message: message)
      end

      class NotPerformedError < self
        def initialize(message: nil, sync:)
          message ||= 'Sync has not been performed.  Call perform before retrieving the result.'

          super(message: message, sync: sync)
        end
      end
    end
  end
end

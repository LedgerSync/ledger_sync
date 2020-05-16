# frozen_string_literal: true

module LedgerSync
  class Operation
    %i[
      create
      update
      patch
      find
      delete
    ].each do |method|
      define_singleton_method(method) do |args = {}|
        operation_for(args.merge(method: method))
      end
    end

    def self.operation_for(args = {})
      client = args.fetch(:client)

      client.operation_for(args.except(:client))
    end
  end
end

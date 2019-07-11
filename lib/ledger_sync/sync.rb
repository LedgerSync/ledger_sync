# frozen_string_literal: true

module LedgerSync
  class Sync
    include LedgerSync::Util::StringHelpers
    include SimplySerializable::Mixin
    include Validatable

    attr_reader :adaptor,
                :method,
                :resources_data,
                :resource_external_id,
                :resource_type

    serialize only: %i[
      adaptor
      method
      operation
      operation_results
      operations
      resource
      resource_external_id
      resource_type
      resources
      resources_data
    ]

    def initialize(
                    adaptor:,
                    method:,
                    resources_data:,
                    resource_external_id:,
                    resource_type:
                  )
      @adaptor = adaptor
      @resource_external_id = resource_external_id
      @resource_type = resource_type
      @method = method
      @resources_data = Util::HashHelpers.deep_symbolize_keys(resources_data)
    end

    def perform
      @perform ||= begin
        raise 'Missing adaptor' if adaptor.nil?
        raise 'Missing operation' if operation.nil?

        validate
          .and_then { performer.perform }
          .on_success { return SyncResult.Success(sync: self) }
          .on_failure { return SyncResult.Failure(sync: self) }
      end
    end

    def coordinator
      @coordinator ||= Util::Coordinator.new(
        operation: operation
      )
    end

    def operations
      @operations ||= coordinator.operations
    end

    def operation
      @operation ||= Adaptors::Operation.klass_from(
        adaptor: adaptor,
        method: method,
        object: resource_type
      ).new(
        adaptor: adaptor,
        resource: resource
      )
    end

    def operation_results
      @operation_results ||= performer.results
    end

    def performer
      @performer ||= Util::Performer.new(operations: operations)
    end

    def resource
      @resource ||= resources_builder.resource
    end

    def resources
      @resources ||= resources_builder.resources
    end

    def resources_builder
      @resources_builder ||= Util::ResourcesBuilder.new(
        data: resources_data,
        root_resource_external_id: resource_external_id,
        root_resource_type: resource_type
      )
    end

    private

    def validate
      operations.inject(Result.Success) do |result, op|
        result.and_then { op.validate }
      end
    end
  end
end

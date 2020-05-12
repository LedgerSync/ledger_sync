# frozen_string_literal: true

module QA
  module LedgerHelpers
    def create_resource_for(*args)
      create_result_for(*args).raise_if_error.resource
    end

    def create_result_for(connection:, resource:)
      result_for(
        connection: connection,
        method: :create,
        resource: resource
      )
    end

    def delete_resource_for(*args)
      delete_result_for(*args).raise_if_error.resource
    end

    def delete_result_for(connection:, resource:)
      result_for(
        connection: connection,
        method: :delete,
        resource: resource
      )
    end

    def find_resource_for(*args)
      find_result_for(*args).raise_if_error.resource
    end

    def find_result_for(connection:, resource:)
      result_for(
        connection: connection,
        method: :find,
        resource: resource
      )
    end

    def result_for(connection:, method:, resource:)
      connection.operation_for(
        method: method,
        resource: resource
      ).perform
    end

    def update_resource_for(*args)
      update_result_for(*args).raise_if_error.resource
    end

    def update_result_for(connection:, resource:)
      result_for(
        connection: connection,
        method: :update,
        resource: resource
      )
    end
  end
end

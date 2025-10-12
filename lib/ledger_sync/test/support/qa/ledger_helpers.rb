# frozen_string_literal: true

module LedgerSync
  module Test
    module QA
      module LedgerHelpers
        def create_resource_for(*)
          create_result_for(*).raise_if_error.resource
        end

        def create_result_for(client:, resource:)
          result_for(
            client: client,
            method: :create,
            resource: resource
          )
        end

        def delete_resource_for(*)
          delete_result_for(*).raise_if_error.resource
        end

        def delete_result_for(client:, resource:)
          result_for(
            client: client,
            method: :delete,
            resource: resource
          )
        end

        def find_resource_for(*)
          find_result_for(*).raise_if_error.resource
        end

        def find_result_for(client:, resource:)
          result_for(
            client: client,
            method: :find,
            resource: resource
          )
        end

        def result_for(client:, method:, resource:)
          client.operation_for(
            method: method,
            resource: resource
          ).perform
        end

        def update_resource_for(*)
          update_result_for(*).raise_if_error.resource
        end

        def update_result_for(client:, resource:)
          result_for(
            client: client,
            method: :update,
            resource: resource
          )
        end
      end
    end
  end
end

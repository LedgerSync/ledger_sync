# frozen_string_literal: true

module QA
  module AdaptorHelpers
    def create_resource_for(*args)
      create_result_for(*args).raise_if_error.resource
    end

    def create_result_for(adaptor:, resource:)
      result_for(
        adaptor: adaptor,
        method: :create,
        resource: resource
      )
    end

    def delete_resource_for(*args)
      delete_result_for(*args).raise_if_error.resource
    end

    def delete_result_for(adaptor:, resource:)
      result_for(
        adaptor: adaptor,
        method: :delete,
        resource: resource
      )
    end

    def find_resource_for(*args)
      find_result_for(*args).raise_if_error.resource
    end

    def find_result_for(adaptor:, resource:)
      result_for(
        adaptor: adaptor,
        method: :find,
        resource: resource
      )
    end

    def result_for(adaptor:, method:, resource:)
      adaptor.operation_for(
        method: method,
        resource: resource
      ).perform
    end

    def update_resource_for(*args)
      update_result_for(*args).raise_if_error.resource
    end

    def update_result_for(adaptor:, resource:)
      result_for(
        adaptor: adaptor,
        method: :update,
        resource: resource
      )
    end
  end
end

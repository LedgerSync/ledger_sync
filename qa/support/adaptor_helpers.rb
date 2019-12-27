# frozen_string_literal: true

module AdaptorHelpers
  def adaptor_class
    raise NotImplementedError
  end

  def create_operation_for(resource_class:)
    operation_for(
      method: :create,
      resource: resource_class
    )
  end

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

  def delete_operation_for(resource_class:)
    operation_for(
      method: :delete,
      resource: resource_class
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

  def find_operation_for(resource_class:)
    operation_for(
      method: :find,
      resource: resource_class
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

  def operation_for(method:, resource_class:)
    adaptor_class
      .base_operation_module_for(resource_class: resource_class)
      .const_get(LedgerSync::Util::StringHelpers.camelcase(method.to_s))
  end

  def result_for(adaptor:, method:, resource:)
    operation_for(
      method: method,
      resource_class: resource.class
    ).new(
      adaptor: adaptor,
      resource: resource
    ).perform
  end

  def update_operation_for(resource_class:)
    operation_for(
      method: :update,
      resource: resource_class
    )
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
